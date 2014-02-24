package com.upmile.web;

import java.io.File;
import java.io.IOException;
import java.io.Reader;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;

import com.upmile.data.IObject;
import com.upmile.data.IObjectWrapper;
import com.upmile.meta.HtmlTemplateMeta;
import com.upmile.meta.MetaDataManager;
import com.upmile.meta.UrlElementMeta;
import com.upmile.operation.InsertOperationHelper;
import com.upmile.operation.OperationHelper;
import com.upmile.persistence.ConnectionFactory;
import com.upmile.util.CookieUtils;
import com.upmile.util.VelocityHelper;
import com.upmile.util.VelocityUtils;

public class UrlResolverController extends AbstractController {
	static Logger log = Logger.getLogger(UrlResolverController.class);
	
	private static int AUTHENTICATED_USER_REQUIRED = 0;
	private static int COOKIED_USER_REQUIRED = 1;
	private static int GET_USER_DETAILS = 1;
	private static int PROCESS_AUTHORIZE_REPLY = 2;
	private static int CHECK_AUTHORIZE_REPLY = 3;
	private static int PREOP_CHECK_BIZ_OWNER_ENABLED = 4;
	private static int GET_BIZ_DETAILS = 5;
	private static int GET_OFFER_BY_ID = 6;
	private static int SIGN_OUT = 7;
	private static int PREOP_CHECK_IF_USER_BIZ_OWNER = 8;
	private static int GET_ACTIVE_OFFER_BY_ID_IN_URL = 9;
	private static int GET_ACTIVE_OFFERS_BY_USER_ZIPCODE_IF_IN_SESSION = 10;
	private static int GET_MY_ACTIVE_OFFERS = 11;
	private static int GET_MY_ORDERS = 12;
	private static int POSTOP_INSERT_NEW_BIZ = 13;
	private static int PREOP_UPDATE_BIZ = 14;
	private static int POSTOP_INSERT_NEW_DEAL = 15;
	
	VelocityHelper velocityHelper;

	

	@Override
	protected ModelAndView handleRequestInternal(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String method = req.getMethod();
		log.debug("Method: " + method);
		return process(req, res);
	}

	
	
	private ModelAndView process(HttpServletRequest request, HttpServletResponse res) throws Exception {
        ModelAndView mav = null;
        try {
            if(request.getMethod().equals("GET"))
            	mav = processRequest(request, res);
            else
            	mav = processPost(request, res);
            ConnectionFactory.getInstance().commitAndReleaseConn();
        } catch (Exception ex) {
        	ConnectionFactory.getInstance().rollbackAndReleaseConn();
        	log.error("Exception: " + ex.getMessage(), ex);
        }
        return mav;
	}

	private ModelAndView processPost(HttpServletRequest request, HttpServletResponse res) throws Exception{
    	ModelAndView mav = null;
    	UrlElementMeta urlElement = null;
    	String reqUri = request.getRequestURI();
        log.debug("post reqUri: " + reqUri);
        urlElement = getResolvedUrlElementMeta(reqUri);
    	for(Integer postOp : urlElement.getPostOps()){
    		if(postOp.intValue() == POSTOP_INSERT_NEW_BIZ){
				mav = insertNewBiz(urlElement.getTemplate(), request, res);
			}else if(postOp.intValue() == POSTOP_INSERT_NEW_DEAL){
				mav = insertNewDeal(urlElement.getTemplate(), request, res);
			}	
    	}
        return mav;
	}
    
	private ModelAndView insertNewDeal(HtmlTemplateMeta template, HttpServletRequest request, HttpServletResponse res) throws Exception {
		boolean success = false;
		try{
			InsertOperationHelper oh = new InsertOperationHelper(62, request, res);
			FileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			JSONObject flds = new JSONObject();
			JSONArray pics = new JSONArray();
			@SuppressWarnings("unchecked")
			List<FileItem> list = upload.parseRequest(request);
			for(FileItem fi : list){
				if(!fi.isFormField()){
					pics.put(saveFile(fi));
				}else
					flds.accumulate(fi.getFieldName(), fi.getString());
			} 
			flds.put("pics", pics);
			oh.addFields(flds);
			oh.execOperation();
			success = true;
		}catch(Exception e){
			log.error(e.getMessage(), e);
		}
		velocityHelper.setTemplateName(template.getTemplate());
		if(success){
			velocityHelper.addVariable("status", "success");
		}else
			velocityHelper.addVariable("status", "error");
		
		return returnView(velocityHelper.renderTemplate(), request, res);
	}



	private ModelAndView processRequest(HttpServletRequest request, HttpServletResponse res) throws Exception{
    	ModelAndView mav = null;
    	UrlElementMeta resolvedUrlElement = null;
    	String reqUri = request.getRequestURI();
        log.debug("reqUri: " + reqUri);
        Enumeration<String> en = request.getParameterNames();
        StringBuffer params = new StringBuffer();
        while(en.hasMoreElements()){
        	String pname = (String)en.nextElement();
        	String pvalue = request.getParameter(pname);
        	if(params.length() > 0)
        		params.append("&");
        	params.append(pname + "=" + pvalue);
        }
        resolvedUrlElement = getResolvedUrlElementMeta(reqUri);
        if(resolvedUrlElement != null){
        	if(checkPreOps(request, res, resolvedUrlElement, reqUri, params.toString()))
        		mav = renderTemplateForGet(request, res, resolvedUrlElement.getTemplate(), reqUri);
        }else{
        	if(reqUri.equals("/favicon.ico"))
        		res.sendRedirect("/static/images/31.ico");
        	else if(reqUri.indexOf("exapt") != -1)
        		res.sendRedirect("http://exapt.upmile.com/biz/exapt");
        	else
        		mav = renderTemplateForGet(request, res, getNotFoundTemplate(), reqUri);
        }
        return mav;
    }
    
    private boolean checkPreOps(HttpServletRequest request, HttpServletResponse res, UrlElementMeta urlElement, String uri, String params) throws Exception{
    	IObject user = getUser(request, res);
    	for(Integer preOp : urlElement.getGetPreOps()){
			if(preOp.intValue() == AUTHENTICATED_USER_REQUIRED){
				if(user == null || !request.getSession().getAttribute(Constants.USER_SESSION_STATUS).equals(Constants.SESSION_STATUS_AUTHENTICATED)){
					if(!params.isEmpty())
						uri += "?" + params;
					res.sendRedirect("/signin?goto=" + uri);
					return false;
				}
			}else if(preOp.intValue() == COOKIED_USER_REQUIRED){
				if(user == null){
					if(!params.isEmpty())
						uri += "?" + params;
					res.sendRedirect("/signin?goto=" + uri);
					return false;
				}
			}else if(preOp.intValue() == CHECK_AUTHORIZE_REPLY){
				if(!checkAuthorizeReply(uri, request, res)){
					//res.sendRedirect("/not-found");
					renderTemplateForGet(request, res, getNotFoundTemplate(), uri);
					return false;
				}
			}else if(preOp.intValue() == PREOP_CHECK_BIZ_OWNER_ENABLED){
				if(!checkUserCanRegBiz(request, res)){
					res.sendRedirect("/not-found");
					return false;
				}
			}else if(preOp.intValue() == PREOP_UPDATE_BIZ){
				if(!updateBiz(request, res)){
					res.sendRedirect("/not-found");
					return false;
				}
			}else if(preOp.intValue() == PREOP_CHECK_IF_USER_BIZ_OWNER){
				if(!checkUserBizOwner(request, res)){
					res.sendRedirect("/not-found");
					return false;
				}
			}
		}
    	return true;
    }
    
    private ModelAndView renderTemplateForGet(HttpServletRequest request, HttpServletResponse res, HtmlTemplateMeta tmpl, String uri) {
    	ModelAndView mav = null;
    	try{
    		IObject user = getUser(request, res);
    		velocityHelper.setTemplateName(tmpl.getTemplate());
    		for(Integer postOp : tmpl.getOps()){
    			if(postOp.intValue() == GET_USER_DETAILS){
    				velocityHelper.addVariable("user", getUserDetails(request, res));
    			}else if(postOp.intValue() == PROCESS_AUTHORIZE_REPLY){
    				processAuthorizeReply(uri, request, res, velocityHelper);
    			}else if(postOp.intValue() == GET_BIZ_DETAILS){
    				velocityHelper.addVariable("biz", getBizDetails(user, request, res));
    			}else if(postOp.intValue() == GET_OFFER_BY_ID){
    				velocityHelper.addVariable("offer", getOffer(user, request, res));
    			}else if(postOp.intValue() == SIGN_OUT){
    				signout(request, res);
    			}else if(postOp.intValue() == GET_ACTIVE_OFFER_BY_ID_IN_URL){
    				getOfferByIdInUrl(velocityHelper, uri, request, res);
    			}else if(postOp.intValue() == GET_ACTIVE_OFFERS_BY_USER_ZIPCODE_IF_IN_SESSION){
    				getActiveOffersByUserZipcode(velocityHelper, uri, request, res);
    			}else if(postOp.intValue() == GET_MY_ACTIVE_OFFERS){
    				getMyActiveOffers(velocityHelper, uri, request, res);
    			}else if(postOp.intValue() == GET_MY_ORDERS){
    				getMyOrders(velocityHelper, uri, request, res);
    			}
    		}
    		mav = returnView(velocityHelper.renderTemplate(), request, res);
    	}catch(Exception e){
    		log.error(e.getMessage(), e);
    	}
    	return mav;
    }
    
	@SuppressWarnings("unchecked")
	private boolean updateBiz(HttpServletRequest request, HttpServletResponse res) throws Exception {
		OperationHelper opUpdateBiz = new OperationHelper(54, request, res);
		OperationHelper opUpdateLoc = new OperationHelper(55, request, res);
		FileItemFactory factory = new DiskFileItemFactory();
    	ServletFileUpload upload = new ServletFileUpload(factory);
    	JSONObject job = new JSONObject();
    	List<FileItem> list = upload.parseRequest(request);
    	for(FileItem fi : list){
    		if(!fi.isFormField()){
    			String logoFName = saveFile(fi);
    			opUpdateBiz.addField("logo", logoFName);
    			job.accumulate("logo", logoFName);
    		}else{
    			if(fi.getFieldName().equals("id")){
    				opUpdateBiz.addParameter("id", fi.getString());
    				opUpdateLoc.addParameter("id", fi.getString());
    			}else if(fi.getFieldName().equals("locid"))
    				opUpdateLoc.addParameter("biz_id", fi.getString());
    			else if(fi.getFieldName().equals("name") || fi.getFieldName().equals("description") ||
    			fi.getFieldName().equals("phone") || fi.getFieldName().equals("email"))
    				opUpdateBiz.addField(fi.getFieldName(), fi.getString());
    				if(fi.getFieldName().equals("name") || fi.getFieldName().equals("phone"))
    					job.accumulate(fi.getFieldName(), fi.getString());
    			else
    				opUpdateLoc.addField(fi.getFieldName(), fi.getString());
    		}
    	}
    	opUpdateBiz.execOperation();
    	opUpdateLoc.execOperation();
    	OperationHelper opUpdateOffers = new OperationHelper(58, request, res);
    	opUpdateOffers.addField("biz_name", job);
    	opUpdateOffers.execOperation();
		return true;
	}

	@SuppressWarnings("unchecked")
	private ModelAndView insertNewBiz(HtmlTemplateMeta template, HttpServletRequest request, HttpServletResponse res) throws Exception {
		boolean success = false;
		try{
			InsertOperationHelper oh = new InsertOperationHelper(19, request, res);
			FileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			JSONArray locs = new JSONArray();
			JSONObject jObj = new JSONObject();
			JSONObject flds = new JSONObject();
			//if(request.getContentType() != null && request.getContentType().equals("multipart/form-data")){
				List<FileItem> list = upload.parseRequest(request);
				for(FileItem fi : list){
					log.debug("field: " + fi.getFieldName() + " ,value: " + fi.getString());
					if(!fi.isFormField()){
						oh.addField("logo", saveFile(fi));
					}else{
						if(fi.getFieldName().equals("name") || fi.getFieldName().equals("category_id") || 
								fi.getFieldName().equals("subcategory_id") || fi.getFieldName().equals("owner_id") || 
								fi.getFieldName().equals("uuid") || fi.getFieldName().equals("email") || 
								fi.getFieldName().equals("phone"))
							flds.accumulate(fi.getFieldName(), fi.getString());
						else{
							jObj.accumulate(fi.getFieldName(), fi.getString());
							if(fi.getFieldName().equals("zipcode")){
								//get longitude, latitude
								OperationHelper zipOper = new OperationHelper(28, request, res);
								zipOper.addParameter("zipcode", fi.getString());
								IObject obj = zipOper.execOperation().getObject();
								jObj.accumulate("longitude", obj.getINode("longitude").getValue());
								jObj.accumulate("latitude", obj.getINode("latitude").getValue());
							}
						}
					}
				}
			locs.put(jObj);
			flds.put("locations", locs);
			oh.addFields(flds);
			oh.execOperation();
			success = true;
		}catch(Exception e){
			log.error(e.getMessage(), e);
		}
		velocityHelper.setTemplateName(template.getTemplate());
		if(success){
			velocityHelper.addVariable("status", "success");
		}else
			velocityHelper.addVariable("status", "error");
		
		return returnView(velocityHelper.renderTemplate(), request, res);
	}

    private String saveFile(FileItem fi) throws Exception{
    	String fName = String.valueOf(Calendar.getInstance().getTimeInMillis()) + "_" + fi.getName(); 
    	File file = new File(VelocityUtils.getUploadedImagesPath() + fName);
    	fi.write(file);
    	return fName;
    }
	
	
	private void getMyOrders(VelocityHelper vh, String uri, HttpServletRequest request, HttpServletResponse res) throws Exception {
		OperationHelper oh = new OperationHelper(6, request, res, vh);
		oh.execOperation();
	}

	private void getMyActiveOffers(VelocityHelper vh, String uri, HttpServletRequest request, HttpServletResponse res) throws Exception {
		OperationHelper oh = new OperationHelper(7, request, res, vh);
		oh.execOperation();
	}

	private void getActiveOffersByUserZipcode(VelocityHelper vh, String uri, HttpServletRequest request, HttpServletResponse res) throws Exception {
		OperationHelper oh;
		IObject user = (IObject)request.getSession().getAttribute(Constants.USER);
		if(user == null || (user != null && user.getINode("zipcode") == null)){
			oh = new OperationHelper(13, request, res, vh);
			oh.addParameter("zip", "");
		}else{
			oh = new OperationHelper(17, request, res, vh);
			oh.addParameter("zip", user.getINode("zipcode").getValue().toString());
		}
		oh.execOperation();
	}

	private boolean checkUserBizOwner(HttpServletRequest request, HttpServletResponse res) {
    	try {
    		IObject user = (IObject) request.getSession().getAttribute(Constants.USER);
    		if(user.getINode("biz_owner").getValue().toString().equals("2"))
    			return true;
    	}catch(Exception ex){
    		log.error("Exception: " + ex.getMessage(), ex);
    	}
		return false;
	}

	private void signout(HttpServletRequest request, HttpServletResponse res) throws Exception {
    	CookieUtils.removeCookie(res);
		request.getSession().removeAttribute(Constants.USER);
		request.getSession().removeAttribute(Constants.USER_SESSION_STATUS);
		res.sendRedirect("/");
	}

	private String getOffer(IObject user, HttpServletRequest request, HttpServletResponse res) {
    	String ret = "[]";
    	String oid = "";
    	if(user == null)
    		return ret;
    	try {
            Enumeration<String> en = request.getParameterNames();
            while(en.hasMoreElements()){
            	String pname = (String)en.nextElement();
            	if(pname.equals("oid"))
            		oid = request.getParameter(pname);
            }
            if(oid.isEmpty())
            	return ret;
            OperationHelper oh = new OperationHelper(24, request, res);
            oh.addParameter("user_id", user.getINode("id").getValue().toString());
            oh.addParameter("id", oid);
    		ret = oh.execOperation().serializeObjectsToJSONString();
    	}catch(Exception ex){
    		log.error("Exception: " + ex.getMessage(), ex);
    	}
    	return ret;
	}

	private void processAuthorizeReply(String uri, HttpServletRequest request, HttpServletResponse res, VelocityHelper vh) {
    	String[] split = uri.split("/");
    	try {
    		OperationHelper oh = null;
    		if(split[4].equals("0"))
    			oh = new OperationHelper(15, request, res);
    		else
    			oh = new OperationHelper(16, request, res);
    		oh.addParameter("id", split[3]);
    		oh.addParameter("uuid", split[2]);
    		oh.execOperation();
    		vh.addVariable("user", getUserDetails(request, res));
    	}catch(Exception ex){
    		log.error("Exception: " + ex.getMessage(), ex);
    	}
		
	}

	private UrlElementMeta getResolvedUrlElementMeta(String uri){
		UrlElementMeta ret = null;
    	String[] splitUri = uri.split("/");
        UrlElementMeta root = MetaDataManager.getRootUrlElement();
        if(splitUri.length == 0)
        	ret = root;
        else {
        	UrlElementMeta uem = root.getChildrenElements().get(splitUri[1]);
        	for(int i = 1; i <= splitUri.length; i++){
        		if(uem == null)
        			break;
        		if(uem.getTemplate() != null)
        			ret = uem;
        		int nInd = i + 1;
        		if(nInd < splitUri.length){
        			if(!uem.getChildrenElements().containsKey(splitUri[nInd]))
        				break;
        			else
        				uem = uem.getChildrenElements().get(splitUri[nInd]);
        		}
        	}
        }
    	return ret;
    }
    
	private HtmlTemplateMeta getNotFoundTemplate(){
		UrlElementMeta root = MetaDataManager.getRootUrlElement();
		UrlElementMeta nf =  root.getChildrenElements().get("not-found");
		return nf.getTemplate();
	}
	
    private ModelAndView returnView(String view, HttpServletRequest req, HttpServletResponse res) throws Exception{
		ModelAndView mav = new ModelAndView();
		GenericView gv = new GenericView(view, "text/html");
		mav.setView(gv);
		return mav;
    }
    
    private IObject getUser(HttpServletRequest request, HttpServletResponse res) {
    	IObject user = (IObject)request.getSession().getAttribute(Constants.USER);
		if(user != null)
			return user;
    	
		try{
			String[] cookVals = CookieUtils.getValuesFromCookie(request);
			if(cookVals != null)
				setUserToSession(cookVals[0], cookVals[1], request, res);
			return (IObject)request.getSession().getAttribute(Constants.USER);
		}catch(Exception e){
			log.error("Exception: " + e.getMessage(), e);
		}
		return null;
    }

    private void getOfferByIdInUrl(VelocityHelper vh, String uri, HttpServletRequest request, HttpServletResponse res){
    	IObjectWrapper ret = null;
    	String[] split = uri.split("/");
    	try {
    		OperationHelper oh = new OperationHelper(56, request, res, vh);
    		oh.addParameter("id", split[2]);
    		ret = oh.execOperation();
    		vh.addVariable("offersHTML", ret.getRenderedHTML());
    	}catch(Exception ex){
    		log.error("Exception: " + ex.getMessage());
    		vh.addVariable("offersHTML", "<div>Oops, no offer is found.</div>");
    	}
    }

    
    private boolean checkAuthorizeReply(String uri, HttpServletRequest request, HttpServletResponse res){
    	String[] split = uri.split("/");
    	boolean ret = false;
    	try {
    		if(!split[4].equals("0") && !split[4].equals("1"))
    			return ret;
    		OperationHelper oh = new OperationHelper(14, request, res);
    		oh.addParameter("id", split[3]);
    		oh.addParameter("uuid", split[2]);
    		if(oh.execOperation().getObjects().size() > 0)
    			ret = true;
    	}catch(Exception ex){
    		log.error("Exception: " + ex.getMessage(), ex);
    	}
    	return ret;
    }

    private boolean checkUserCanRegBiz(HttpServletRequest request, HttpServletResponse res){
    	boolean ret = false;
    	try {
    		OperationHelper oh = new OperationHelper(18, request, res);
    		if(oh.execOperation().getObjects().size() > 0)
    			ret = true;
    	}catch(Exception ex){
    		log.error("Exception: " + ex.getMessage(), ex);
    	}
    	return ret;
    }
    
    private void setUserToSession(String id, String uuid, HttpServletRequest request, HttpServletResponse res){
    	try {
    		OperationHelper oh = new OperationHelper(9, request, res);
    		oh.addParameter("id", id);
    		oh.addParameter("uuid", uuid);
    		IObjectWrapper iow = oh.execOperation();
    		if(iow.getObjects() == null || iow.getObjects().isEmpty())
    			return;
    		
    		IObject user = (IObject) iow.getObjects().toArray()[0];
    		if(request.getSession().getAttribute(Constants.USER_SESSION_STATUS) != null)
    			CookieUtils.addUserToSession(user, (String)request.getSession().getAttribute(Constants.USER_SESSION_STATUS), request);
    		else	
    			CookieUtils.addUserToSession(user, Constants.SESSION_STATUS_COOKIED, request);
    		
    	}catch(Exception ex){
    		log.error("Exception: " + ex.getMessage(), ex);
    	}
    }

    private String getUserDetails(HttpServletRequest request, HttpServletResponse res) throws Exception{
    	IObject user = (IObject)request.getSession().getAttribute(Constants.USER);
    	String ret = "[]";
    	if(user == null)
    		return ret;
    	JSONArray ja = new JSONArray();
    	ja.put(user.getJSONObj());
    	return ja.toString();
    }

    
    private IObject getBizDetails(IObject user, HttpServletRequest request, HttpServletResponse res){
    	IObject ret = null;
    	if(user == null)
    		return ret;
    	try {
    		OperationHelper oh = new OperationHelper(23, request, res);
    		oh.addParameter("owner_id", user.getINode("id").getValue().toString());
    		ret = (IObject) oh.execOperation().getObjects().toArray()[0];
    	}catch(Exception ex){
    		log.error("Exception: " + ex.getMessage(), ex);
    	}
    	return ret;
    }



	public VelocityHelper getVelocityHelper() {
		return velocityHelper;
	}



	public void setVelocityHelper(VelocityHelper velocityHelper) {
		this.velocityHelper = velocityHelper;
	}
	
	
	
	
}
