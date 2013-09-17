package com.upmile.operation;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.mysql.jdbc.exceptions.MySQLTransactionRollbackException;
import com.upmile.data.INode;
import com.upmile.data.IObject;
import com.upmile.data.IObjectWrapper;
import com.upmile.data.ObjectImpl;
import com.upmile.data.ObjectWrapperImpl;
import com.upmile.data.PrimitiveNodeImpl;
import com.upmile.meta.MetaDataManager;
import com.upmile.meta.OperationMeta;
import com.upmile.meta.OperationParamMeta;
import com.upmile.util.CookieUtils;
import com.upmile.util.OfferVelocityHelper;
import com.upmile.util.VelocityHelper;
import com.upmile.web.Constants;


public abstract class Operation {
	static Logger log = Logger.getLogger(Operation.class);
	
	
	protected OperationMeta om;
	protected JSONObject jobj;
	protected JSONObject params;
	protected Collection<IObject> objColl = new ArrayList<IObject>();
	protected HttpServletRequest httpReq;
	protected HttpServletResponse httpResp;
	protected IObjectWrapper resOW = new ObjectWrapperImpl();
	protected VelocityHelper vh = null;
	
	public Operation(JSONObject obj, OperationMeta om, HttpServletRequest httpReq, HttpServletResponse httpResp) throws Exception{
		this.jobj = obj;
		this.om = om;
		this.httpReq = httpReq;
		this.httpResp = httpResp;
		//resOW = new ObjectWrapperImpl();
	}
	
	public Operation(VelocityHelper vh, JSONObject obj, OperationMeta om, HttpServletRequest httpReq, HttpServletResponse httpResp) throws Exception{
		this.jobj = obj;
		this.om = om;
		this.httpReq = httpReq;
		this.httpResp = httpResp;
		this.vh = vh;
	}
	
	
	public IObjectWrapper performOperation() throws MySQLTransactionRollbackException, Exception{
		if(performPreOps()){
			performDataOperation();
			performPostOps();
		}
		return resOW;
	}
	
	private void performPostOps() throws Exception {
		for(Integer op : om.getPostOps()){
			if(op.intValue() == OperationMeta.REGISTER_USER)
				createUserCookieAndAddToSession();
			else if(op.intValue() == OperationMeta.SIGNIN)
				signin();
			else if(op.intValue() == OperationMeta.POST_OP_UPDATE_BIZ_OWNER)
				updateUserBizOwned();
			else if(op.intValue() == OperationMeta.POST_OP_SEND_EMAIL_AUTHORIZATION)
				newUserEmailVerification();
			else if(op.intValue() == OperationMeta.POST_OP_SEND_RESET_PASSWORD_EMAL)
				sendResetPasswordEmail();
			else if(op.intValue() == OperationMeta.POST_OP_SET_USER_TO_SESSION_AFTER_AUTHORIZATION_CONFIRM)
				setUserToSessionAfterEmailUthorization();
			else if(op.intValue() == OperationMeta.POST_OP_REFRESH_USER_IN_SESSION)
				refreshUserInSession();
			else if(op.intValue() == OperationMeta.POST_OP_SEND_OFFER_DISCOUNT_UPDATE_EMAIL)
				sendOfferDiscountUpdate();
			else if(op.intValue() == OperationMeta.POST_OP_RENDER_OFFER_HTML)
				renderOfferHtml();
			else if(op.intValue() == OperationMeta.POST_OP_RENDER_MY_ORDERS_HTML)
				renderMyOrdersHtml();
			else if(op.intValue() == OperationMeta.POST_OP_RENDER_MY_OFFERS_HTML)
				renderMyOffersHtml();
			else if(op.intValue() == OperationMeta.POST_OP_NEW_OFFER_ITEMS_UPDATE)
				updateNewOfferItems();
			else if(op.intValue() == OperationMeta.POST_OP_UPDATED_OFFER_ITEMS_UPDATE)
				updateUpdatedOfferItems();
			else if(op.intValue() == OperationMeta.POST_OP_SEND_NEW_ORDER_EMAIL)
				sendNewOrderEmail();
			else if(op.intValue() == OperationMeta.POST_OP_CUSTOMER_UPDATED_ORDER_EMAIL)
				sendCustomerUpdatedOrderEmail();

		}
	}

	private void sendCustomerUpdatedOrderEmail() throws Exception {
		IObject customer = (IObject)httpReq.getSession().getAttribute(Constants.USER);
		VelocityHelper vh = new VelocityHelper("emailCustomerUpdatedOrder.vm");
		OperationHelper oh = new OperationHelper(56, httpReq, httpResp);
		oh.addParameter("id", jobj.getJSONObject("parameters").getString("oid"));
		IObject offer = oh.execOperation().getObject();
		OperationHelper op = new OperationHelper(11, httpReq, httpResp);
		op.addParameter("id", offer.getNodeValue("user_id"));
		IObject offerCreator = op.execOperation().getObject();
		vh.addVariable("customer", customer);
		vh.addOfferOrderVariables(offer, resOW.getObject());
		vh.addVariable("offerCreator", offerCreator);
		OperationHelper.savePendingEmail(offerCreator.getNodeValueAsStr("email"), null, vh);
	}

	private void sendCustomerCanceledOrderEmail() throws Exception {
		IObject customer = (IObject)httpReq.getSession().getAttribute(Constants.USER);
		VelocityHelper vh = new VelocityHelper("emailCustomerCanceledOrder.vm");
		OperationHelper oh = new OperationHelper(56, httpReq, httpResp);
		oh.addParameter("id", jobj.getJSONObject("parameters").getString("oid"));
		IObject offer = oh.execOperation().getObject();
		OperationHelper op = new OperationHelper(11, httpReq, httpResp);
		op.addParameter("id", offer.getNodeValue("user_id"));
		IObject offerCreator = op.execOperation().getObject();
		oh = new OperationHelper(61, httpReq, httpResp);
		oh.addParameter("id", jobj.getJSONObject("parameters").getString("ordrid"));
		IObject ordr = oh.execOperation().getObject();
		vh.addVariable("customer", customer);
		vh.addOfferOrderVariables(offer, ordr);
		vh.addVariable("offerCreator", offerCreator);
		OperationHelper.savePendingEmail(offerCreator.getNodeValueAsStr("email"), null, vh);
	}

	private void sendOfferCancelationEmail() throws Exception {
		IObject user = (IObject)httpReq.getSession().getAttribute(Constants.USER);
		OperationHelper oh = new OperationHelper(56, httpReq, httpResp);
		oh.addParameter("id", jobj.getJSONObject("parameters").getString("oid"));
		IObject offer = oh.execOperation().getObject();
		//get offer's active, closed orders
		oh = new OperationHelper(60, httpReq, httpResp);
		oh.addParameter("offer_id", jobj.getJSONObject("parameters").getString("oid"));
		for(IObject order : oh.execOperation().getObjects()){
			if(!user.getNodeValue("id").equals(order.getNodeValue("user_id"))){
				OperationHelper op = new OperationHelper(11, httpReq, httpResp);
				op.addParameter("id", order.getNodeValue("user_id"));
				IObject customer = op.execOperation().getObject();
				VelocityHelper vh = new VelocityHelper("emailOfferCanceled.vm");
				vh.addOfferOrderVariables(offer, order);
				vh.addVariable("customer", customer);
				OperationHelper.savePendingEmail(customer.getNodeValueAsStr("email"), null, vh);
			}
		}
	}

	private void sendNewOrderEmail() throws Exception {
		IObject user = (IObject)httpReq.getSession().getAttribute(Constants.USER);
		VelocityHelper vh = new VelocityHelper("emailNewOrder.vm");
		OperationHelper oh = new OperationHelper(56, httpReq, httpResp);
		oh.addParameter("id", jobj.getJSONObject("parameters").getString("oid"));
		IObject offer = oh.execOperation().getObject();
		OperationHelper op = new OperationHelper(11, httpReq, httpResp);
		op.addParameter("id", offer.getNodeValue("user_id"));
		IObject offerCreator = op.execOperation().getObject();
		vh.addVariable("customer", user);
		vh.addOfferOrderVariables(offer, resOW.getObject());
		vh.addVariable("offerCreator", offerCreator);
		OperationHelper.savePendingEmail(offerCreator.getNodeValueAsStr("email"), null, vh);
	}

	private void updateUpdatedOfferItems() throws Exception {
		OperationHelper oh = new OperationHelper(24, httpReq, httpResp);
		oh.addParameter("id", jobj.getJSONObject("parameters").getJSONObject("id").getString("value"));
		resOW = oh.execOperation();
		updateNewOfferItems();
	}

	private void updateNewOfferItems() throws Exception {
		IObject offer = resOW.getObject();
		JSONArray oItems = new JSONArray();
		for(IObject item : offer.getINode("offer_items").getIObjectValue()){
			JSONObject ji = new JSONObject();
			ji.accumulate("id", item.getNodeValueAsStr("id"));
			ji.accumulate("name", item.getNodeValueAsStr("name"));
			ji.accumulate("price", item.getNodeValueAsStr("price"));
			ji.accumulate("total", item.getNodeValueAsStr("total"));
			ji.accumulate("unit", item.getNodeValueAsStr("unit"));
			oItems.put(ji);
		}
		OperationHelper oh = new OperationHelper(2, httpReq, httpResp);
		oh.addParameter("id", offer.getNodeValueAsStr("id"));
		oh.addField("items", oItems.toString());
		offer.addINode(oh.execOperation().getObject().getINode("items"));
	}

	private void sendOfferDiscountUpdate() throws Exception {
		IObject user = (IObject)httpReq.getSession().getAttribute(Constants.USER);
		OperationHelper oh = new OperationHelper(56, httpReq, httpResp);
		oh.addParameter("id", jobj.getJSONObject("parameters").getString("oid"));
		IObject offer = oh.execOperation().getObject();
		//get offer's active orders
		oh = new OperationHelper(40, httpReq, httpResp);
		oh.addParameter("offer_id", jobj.getJSONObject("parameters").getString("oid"));
		for(IObject order : oh.execOperation().getObjects()){
			if(!user.getNodeValue("id").equals(order.getNodeValue("user_id"))){
				OperationHelper op = new OperationHelper(11, httpReq, httpResp);
				op.addParameter("id", order.getNodeValue("user_id"));
				IObject customer = op.execOperation().getObject();
				VelocityHelper vh = new VelocityHelper("emailOfferDiscountUpdate.vm");
				vh.addOfferOrderVariables(offer, order);
				vh.addVariable("customer", customer);
				OperationHelper.savePendingEmail(customer.getNodeValueAsStr("email"), null, vh);
			}
		}
	}

	private void refreshUserInSession() throws Exception {
		String [] cookVals = CookieUtils.getValuesFromCookie(httpReq);
		OperationHelper oh = new OperationHelper(9, httpReq, httpResp);
		oh.addParameter("id", cookVals[0]);
		oh.addParameter("uuid", cookVals[1]);
		IObjectWrapper iow = oh.execOperation();
		if(iow.getObjects() == null || iow.getObjects().isEmpty())
			return;
		
		IObject user = (IObject) iow.getObjects().toArray()[0];
		if(httpReq.getSession().getAttribute(Constants.USER_SESSION_STATUS) != null)
			CookieUtils.addUserToSession(user, (String)httpReq.getSession().getAttribute(Constants.USER_SESSION_STATUS), httpReq);
		else	
			CookieUtils.addUserToSession(user, Constants.SESSION_STATUS_COOKIED, httpReq);
	}

	private void setUserToSessionAfterEmailUthorization() throws Exception {
		OperationHelper oh = new OperationHelper(9, httpReq, httpResp);
		oh.addParameter("id", jobj.getJSONObject("parameters").getJSONObject("id").getString("value"));
		oh.addParameter("uuid", jobj.getJSONObject("parameters").getJSONObject("uuid").getString("value"));
		IObjectWrapper iow = oh.execOperation();
		if(iow.getObjects() == null || iow.getObjects().isEmpty())
			return;
		
		IObject user = (IObject) iow.getObjects().toArray()[0];
		if(httpReq.getSession().getAttribute(Constants.USER_SESSION_STATUS) != null)
			CookieUtils.addUserToSession(user, (String)httpReq.getSession().getAttribute(Constants.USER_SESSION_STATUS), httpReq);
		else	
			CookieUtils.addUserToSession(user, Constants.SESSION_STATUS_COOKIED, httpReq);
	}

	private void sendResetPasswordEmail() throws Exception {
		OperationHelper oh = new OperationHelper(50, httpReq, httpResp);
		oh.addParameter("email", jobj.getJSONObject("parameters").getJSONObject("email").getString("value"));
		IObject user = oh.execOperation().getObject();
		VelocityHelper vh = new VelocityHelper("emailResetPassword.vm");
		vh.addVariable("password", user.getNodeValueAsStr("password"));
		OperationHelper.savePendingEmail(user.getNodeValueAsStr("email"), null, vh);
		//remove password from returned object
		INode pass = null;
		for(INode node : user.getINodes()){
			if(node.getNodeMeta().getNodeName().equals("password")){
				pass = node;
				break;
			}
		}
		user.getINodes().remove(pass);
	}

	private void newUserEmailVerification() throws Exception{
		IObject user = (IObject) resOW.getObjects().toArray()[0];
		sendEmailConfirmation(user);
	}
	
	private void sendEmailConfirmation(IObject user) throws Exception {
		VelocityHelper vh = new VelocityHelper("emailAccountConfirmation.vm");
		vh.addVariable("user", user);
		OperationHelper.savePendingEmail(user.getNodeValueAsStr("email"), null, vh);
	}

	private void signin() throws Exception {
		createUserCookieAndAddToSession();
	}

	private boolean performPreOps() throws Exception {
		boolean ret = true;
		for(Integer op : om.getPreOps()){
			if(op.intValue() == OperationMeta.PRE_OP_CHECK_IF_USER_EXISTS){
				if(ifUserExists())
					ret = false;
			}else if(op.intValue() == OperationMeta.PRE_OP_CHECK_IF_PASSWORD_MATCH){
				if(!ifPasswordMatch())
					ret = false;
			}else if(op.intValue() == OperationMeta.PRE_OP_USER_UPDATE_CHECK){
				if(!ifUserUpdateCheck())
					ret = false;
			}else if(op.intValue() == OperationMeta.PREOP_CHECK_IF_BIZ_LOCATION_CAN_BE_UPDATED){
				if(!ifUserCanUpdateBizLocation())
					ret = false;
			}else if(op.intValue() == OperationMeta.PREOP_CHECK_IF_USER_CAN_SUBMIT_ORDER){
				if(!ifUserCanSubmitOrder())
					ret = false;
			}else if(op.intValue() == OperationMeta.PRE_OP_PROCESS_UPDATED_OFFER_ITEMS){
				if(!ifUpdatedOfferItemsProcessed())
					ret = false;
			}else if(op.intValue() == OperationMeta.PRE_OP_SET_USER_DETAILS){
				if(!setUserDetailsInOrder())
					ret = false;
			}else if(op.intValue() == OperationMeta.PRE_OP_SEND_OFFER_URL_TO_FRIEND){
				if(!sendOfferUrltoFriend())
					ret = false;
			}else if(op.intValue() == OperationMeta.PRE_OP_SEND_CANCEL_OFFER_EMAIL)
				sendOfferCancelationEmail();
			else if(op.intValue() == OperationMeta.PRE_OP_SEND_CUSTOMER_CANCELED_ORDER_EMAIL)
				sendCustomerCanceledOrderEmail();
			else if(op.intValue() == OperationMeta.PRE_OP_SEND_BIZ_CANCELED_ORDER_EMAIL)
				sendBizCanceledOrderEmail();
			else if(op.intValue() == OperationMeta.PRE_OP_USER_CAN_INSERT_BIZ){
				if(!ifUserCanInsertBiz())
					ret = false;
			}else if(op.intValue() == OperationMeta.PRE_OP_VALIDATE_USER){
				if(!ifUserValid())
					ret = false;
			}else if(op.intValue() == OperationMeta.PRE_OP_USER_CAN_INSERT_NEW_DEAL){
				if(!ifUserCanInsertNewDeal())
					ret = false;
			}
			if(!ret)
				break;
		}
		return ret;
	}

	private boolean ifUserValid() throws Exception {
		OperationHelper oh = new OperationHelper(9, httpReq, httpResp);
		oh.addParameter("id", params.getJSONObject("owner_id").getString("value"));
		oh.addParameter("uuid", params.getJSONObject("uuid").getString("value"));
		Collection<IObject> coll = oh.execOperation().getObjects();
		if(coll.isEmpty())
			return false;
		
		return true;
	}

	private boolean ifUserCanInsertBiz() throws Exception {
		OperationHelper oh = new OperationHelper(9, httpReq, httpResp);
		JSONObject user = jobj.getJSONArray("fields").getJSONObject(0);
		oh.addParameter("id", user.getString("owner_id"));
		oh.addParameter("uuid", user.getString("uuid"));
		Collection<IObject> coll = oh.execOperation().getObjects();
		if(coll.isEmpty())
			return false;
		IObject retUser = (IObject) coll.toArray()[0];
		if(((Integer)retUser.getINode("biz_owner").getValue()).intValue() != 3)
			return true;
		else
			return true;
	}

	private boolean ifUserCanInsertNewDeal() throws Exception {
		OperationHelper oh = new OperationHelper(9, httpReq, httpResp);
		JSONObject user = jobj.getJSONArray("fields").getJSONObject(0);
		oh.addParameter("id", user.getString("user_id"));
		oh.addParameter("uuid", user.getString("uuid"));
		Collection<IObject> coll = oh.execOperation().getObjects();
		if(coll.isEmpty())
			return false;
		IObject retUser = (IObject) coll.toArray()[0];
		if(((Integer)retUser.getINode("biz_owner").getValue()).intValue() == 2)
			return true;
		else
			return false;
	}
	
	
	private void sendBizCanceledOrderEmail() throws Exception {
		IObject user = (IObject)httpReq.getSession().getAttribute(Constants.USER);
		OperationHelper oh = new OperationHelper(61, httpReq, httpResp);
		oh.addParameter("id", jobj.getJSONObject("parameters").getString("ordrid"));
		IObject ordr = oh.execOperation().getObject();
		oh = new OperationHelper(11, httpReq, httpResp);
		oh.addParameter("id", ordr.getNodeValue("user_id"));
		IObject customer = oh.execOperation().getObject();
		oh = new OperationHelper(56, httpReq, httpResp);
		oh.addParameter("id", jobj.getJSONObject("parameters").getString("oid"));
		IObject offer = oh.execOperation().getObject();
		if(!user.getNodeValue("id").equals(ordr.getNodeValue("user_id"))){
			VelocityHelper vh = new VelocityHelper("emailBizCanceledOrder.vm");
			vh.addOfferOrderVariables(offer, ordr);
			vh.addVariable("customer", customer);
			OperationHelper.savePendingEmail(customer.getNodeValueAsStr("email"), null, vh);
		}
	}

	private boolean sendOfferUrltoFriend() {
		IObject mes = (IObject) objColl.toArray()[0];
		VelocityHelper vh = new VelocityHelper("email_share_offer.vm");
		try {
			OperationHelper oh = new OperationHelper(56, httpReq, httpResp);
			oh.addParameter("id", mes.getINode("offer_id").getValue());
			IObject offer = oh.execOperation().getObject();
			vh.addVariable("offer", offer);
			if(mes.getINode("message") != null)
				vh.addVariable("message", mes.getNodeValue("message"));
			vh.addVariable("from", mes.getNodeValueAsStr("from"));
			OperationHelper.savePendingEmail(mes.getNodeValueAsStr("to"), mes.getNodeValueAsStr("from"), vh);
			
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		
		return false;
	}

	private boolean setUserDetailsInOrder() throws Exception {
		IObject user = (IObject)httpReq.getSession().getAttribute(Constants.USER);
		JSONObject uDetails = new JSONObject();
		uDetails.accumulate("id", user.getINode("id").getValue().toString());
		uDetails.accumulate("name", user.getINode("first_name").getValue() + " " + user.getINode("last_name").getValue());
		params.put("user_details", uDetails);
		return true;
	}

	private boolean ifUpdatedOfferItemsProcessed() throws Exception {
		JSONArray items = jobj.getJSONObject("fields").getJSONArray("items");
		for(int i = 0; i < items.length(); i++){
			JSONObject item = (JSONObject) items.get(i);
			if(item.has("id") && item.getInt("total") == 0){
				OperationHelper oh = new OperationHelper(27, httpReq, httpResp);
				oh.addParameter("id", item.getString("id"));
				oh.execOperation();
			}else if(!item.has("id") && item.getInt("total") > 0){
				InsertOperationHelper oh = new InsertOperationHelper(32, httpReq, httpResp);
				JSONObject obj = new JSONObject();
				obj.accumulate("offer_id", jobj.getJSONObject("parameters").getJSONObject("id").getString("value"));
				obj.accumulate("name", item.getString("name"));
				obj.accumulate("description", item.getString("description"));
				obj.accumulate("price", item.getString("price"));
				obj.accumulate("total", item.getString("total"));
				obj.accumulate("unit", item.getString("unit"));
				oh.addFields(obj);
				oh.execOperation();
			}else if(item.has("id") && item.getInt("total") > 0){
				OperationHelper oh = new OperationHelper(26, httpReq, httpResp);
				oh.addField("name", item.getString("name"));
				oh.addField("description", item.getString("description"));
				oh.addField("price", item.getString("price"));
				oh.addField("total", item.getString("total"));
				oh.addParameter("id", item.getString("id"));
				oh.execOperation();
			}
		}
		return true;
	}

	private boolean ifUserCanUpdateBizLocation() throws Exception {
		OperationHelper oh = new OperationHelper(23, httpReq, httpResp);
		Collection<IObject> coll = oh.execOperation().getObjects();
		if(coll.isEmpty())
			return false;
		IObject biz = (IObject) coll.toArray()[0];
		if(!biz.getNodeValueAsStr("id").equals(jobj.getJSONObject("parameters").getJSONObject("biz_id").getString("value")))
			return false;
		
		return true;
	}

	private boolean ifUserUpdateCheck() throws Exception {
		IObject user = (IObject)httpReq.getSession().getAttribute(Constants.USER);
		OperationHelper oh = new OperationHelper(11, httpReq, httpResp);
		oh.addParameter("id", user.getNodeValueAsStr("id"));
		IObject iUser = oh.execOperation().getObject();
		if(!jobj.getJSONObject("fields").getString("email").equals(iUser.getNodeValueAsStr("email"))){
			//check if email already exists
			oh = new OperationHelper(47, httpReq, httpResp);
			oh.addParameter("email", jobj.getJSONObject("fields").getString("email"));
			if(oh.execOperation().getObjects().isEmpty()){
				//set user status to new and create email verification email
				oh = new OperationHelper(53, httpReq, httpResp);
				oh.execOperation();
				iUser.getINode("email").setValue(jobj.getJSONObject("fields").getString("email"));
				sendEmailConfirmation(iUser);
				return true;
			}else{
				generateErrorResponse("The email address already exists. Please try another email address.");
				return false;
			}
		}
		return true;
	}

	private void generateErrorResponse(String message) throws Exception{
		IObject errObj = new ObjectImpl("error", null);
		INode errNode = new PrimitiveNodeImpl(errObj, MetaDataManager.getObjectMeta("error").getNodeMeta("message"), message);
		errObj.addINode(errNode);
		resOW.getObjects().clear();
		resOW.addObject(errObj);
	}
	
	private boolean ifPasswordMatch() throws Exception {
		OperationHelper oh = new OperationHelper(51, httpReq, httpResp);
		oh.addParameter("password", jobj.getJSONObject("parameters").getJSONObject("password").getString("value"));
		if(oh.execOperation().getObjects().isEmpty()){
			generateErrorResponse("Wrong Current Password");
			return false;
		}else
			return true;
	}

	private boolean ifUserExists() throws Exception {
		OperationHelper oh = new OperationHelper(47, httpReq, httpResp);
		oh.addParameter("email", jobj.getJSONArray("fields").getJSONObject(0).getString("email"));
		return !oh.execOperation().getObjects().isEmpty();
	}

	protected abstract void performDataOperation() throws Exception;
	
	private boolean ifUserCanSubmitOrder() throws Exception{
		IObject user = (IObject)httpReq.getSession().getAttribute(Constants.USER);
		if(user == null){
			refreshUserInSession();
			user = (IObject)httpReq.getSession().getAttribute(Constants.USER);
		}
		if(!user.getINode("status").getValue().toString().equals("1")){
			//refresh to check if status changed
			refreshUserInSession();
			user = (IObject)httpReq.getSession().getAttribute(Constants.USER);
			if(!user.getNodeValueAsStr("status").equals("1")){
				generateErrorResponse("Sorry, we can't process your order until you confirm your email address. " +
    				"Please check your inbox for Upmile Account Confirmation email.");
				return false;
			}
		}
		//check if offer is active
		OperationHelper oh = new OperationHelper(56, httpReq, httpResp);
		oh.addParameter("id", jobj.getJSONObject("parameters").getString("oid"));
		if(oh.execOperation().getObjects().isEmpty()){
			generateErrorResponse("Sorry, the offer is closed or unavailable for new orders.");
			return false;
		}
		return true;
	}
	
	private void createUserCookieAndAddToSession() throws Exception{
		if(resOW.getObjects() == null || resOW.getObjects().isEmpty())
			return;
		IObject user = (IObject) resOW.getObjects().toArray()[0];
		CookieUtils.addUserToSession(user, Constants.SESSION_STATUS_AUTHENTICATED, httpReq);
		CookieUtils.createCookie(user, httpResp);
	}
	
	private void updateUserBizOwned() throws Exception{
    	OperationHelper oh = new OperationHelper(20, httpReq, httpResp);
    	JSONObject user = jobj.getJSONArray("fields").getJSONObject(0);
    	oh.addParameter("id", user.getString("owner_id"));
    	oh.addParameter("uuid", user.getString("uuid"));
    	oh.execOperation();
	}
	
	private void renderOffer(String type, Collection<OfferVelocityHelper> offCol) throws Exception{
		VelocityHelper locvh = null;
		if(vh != null)
			locvh = vh;
		else
			locvh = new VelocityHelper("offers_macro.vm");
		
		SimpleDateFormat df = new SimpleDateFormat("EEE, MMM d, ''yy");
		locvh.addVariable("closeDateFormat", df);
		locvh.addVariable("type", type);
		locvh.addVariable("offerslist", offCol);
		if(vh == null)
			resOW.setRenderedHTML(locvh.renderTemplate());
	}
	
	private void renderOfferHtml() throws Exception{
		Collection<OfferVelocityHelper> offCol = new ArrayList<OfferVelocityHelper>();
		for(IObject obj : resOW.getObjects()){
			OfferVelocityHelper ov = new OfferVelocityHelper(obj);
			offCol.add(ov);
		}
		renderOffer("offer", offCol);
	}

	private void renderMyOrdersHtml() throws Exception{
		Collection<OfferVelocityHelper> offCol = new ArrayList<OfferVelocityHelper>();
		for(IObject order : resOW.getObjects()){
			OfferVelocityHelper ov = new OfferVelocityHelper(order, (IObject) order.getINode("offer").getIObjectValue().toArray()[0]);
			offCol.add(ov);
		}
		renderOffer("myorders", offCol);
	}

	private void renderMyOffersHtml() throws Exception {
		Collection<OfferVelocityHelper> offCol = new ArrayList<OfferVelocityHelper>();
		for(IObject offer : resOW.getObjects()){
			OfferVelocityHelper ov = new OfferVelocityHelper(offer, offer.getINode("op").getIObjectValue());
			offCol.add(ov);
		}
		renderOffer("myoffers", offCol);
	}
	
	public String getValue(OperationParamMeta opm) throws Exception{
		Object value = null;
		if(opm.getValueType() == OperationParamMeta.VALUE_TYPE_SESSION){
			IObject obj = (IObject)httpReq.getSession().getAttribute(opm.getSessionValue()[0]);
			if(obj == null){
				refreshUserInSession();
				obj = (IObject)httpReq.getSession().getAttribute(opm.getSessionValue()[0]);
			}
			value = obj.getINode(opm.getSessionValue()[1]).getValue().toString();
		}else if(opm.getValueType() == OperationParamMeta.VALUE_TYPE_UUID)
			value = UUID.randomUUID().toString();
		else if(opm.getValueType() == OperationParamMeta.VALUE_TYPE_META)
			value = opm.getValue();
		else if(opm.getValueType() == OperationParamMeta.VALUE_TYPE_CURRENT_DATE){
			SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy h:mm a");
			Date dt = new Date(Calendar.getInstance().getTimeInMillis());
			value = df.format(dt);
		}else if(opm.getValueType() == OperationParamMeta.VALUE_TEMP_PASSWORD){
		    String pass = "";
		    for(int i = 0; i <= 6; i++){
		    	pass += Double.valueOf(Math.floor(Math.random() * 10)).intValue();
		    }
		    value = pass;
		}
		return (String)value;
	}

	
}
