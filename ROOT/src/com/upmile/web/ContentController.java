package com.upmile.web;

import java.io.IOException;
import java.io.Reader;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;

import com.mysql.jdbc.exceptions.MySQLTransactionRollbackException;
import com.upmile.operation.Operation;
import com.upmile.operation.OperationFactory;
import com.upmile.persistence.ConnectionFactory;

public class ContentController extends AbstractController {
	static Logger log = Logger.getLogger(ContentController.class);

	@Override
	protected ModelAndView handleRequestInternal(HttpServletRequest req, HttpServletResponse res) throws Exception {
		return doRequest(req, res);
	}

    private ModelAndView doRequest(HttpServletRequest req, HttpServletResponse res) throws Exception{
    	ModelAndView mav = null;
    	boolean status = false;
        while(!status){
            try {
            	mav = processPayload(req, res);
            	ConnectionFactory.getInstance().commitAndReleaseConn();
            	status = true;
            } catch (MySQLTransactionRollbackException ex) {
            	ConnectionFactory.getInstance().rollback();
                Thread.sleep(50);
            	log.error("Exception: " + ex.getMessage(), ex);
            }catch (Exception ex) {
            	status = true;
            	ConnectionFactory.getInstance().rollbackAndReleaseConn();
            	log.error("Exception: " + ex.getMessage(), ex);
            }
        }
        return mav;
    }
    
    private ModelAndView processPayload(HttpServletRequest req, HttpServletResponse res) throws MySQLTransactionRollbackException, Exception {
    	String payload = req.getParameter("payload");
        String dataType = req.getParameter("datatype");
        if(payload == null){
            Reader reader = req.getReader();
    	    char[] buffer = new char[(int) req.getContentLength()];
    	    reader.read(buffer);
    	    String ret = new String(buffer);
    	    String[] spl = ret.split("&");
    	    for(int i = 0; i < spl.length; i++){
    	    	String[] sub = spl[i].split("=");
    	    	if(sub[0].equals("payload"))
    	    		payload = sub[1];
    	    	else if(sub[0].equals("datatype"))
    	    		dataType = sub[1];
    	    }
        }
        JSONArray payloadJA = new JSONArray(payload);
        if(dataType.equals("json"))
        	return processJSONDataType(payloadJA, req, res);
        else
        	return processHTMLDataType(payloadJA, req, res);
    }
    
    private ModelAndView processJSONDataType(JSONArray payload, HttpServletRequest req, HttpServletResponse res) throws MySQLTransactionRollbackException, Exception{
    	JSONArray respJA = new JSONArray();
		for(int i = 0; i < payload.length(); i++){
			JSONObject obj = payload.getJSONObject(i);
			log.debug(obj.toString());
			Operation oper = OperationFactory.getOperation(obj, req, res, null);
			oper.performOperation().addObjectsToJSONArray(respJA);
		}
		return setToResponse(res, respJA.toString(), "json");
    }
    
    private ModelAndView processHTMLDataType(JSONArray payload, HttpServletRequest req, HttpServletResponse res) throws Exception{
    	StringBuffer respSB = new StringBuffer();
		for(int i = 0; i < payload.length(); i++){
			JSONObject obj = payload.getJSONObject(i);
			log.debug(obj.toString());
			Operation oper = OperationFactory.getOperation(obj, req, res, null);
			respSB.append(oper.performOperation().getRenderedHTML());
		}
		return setToResponse(res, respSB.toString(), "text/html");
    }

    
    private ModelAndView setToResponse(HttpServletResponse response, String payload, String contentType) throws IOException {
		ModelAndView mav = new ModelAndView();
		GenericView gv = new GenericView(payload, contentType);
		mav.setView(gv);
		return mav;
    }
	
	
}
