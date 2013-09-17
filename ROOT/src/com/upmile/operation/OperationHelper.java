package com.upmile.operation;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.upmile.data.IObjectWrapper;
import com.upmile.meta.MetaDataManager;
import com.upmile.meta.OperationMeta;
import com.upmile.util.VelocityHelper;

public class OperationHelper {

	protected JSONObject oper;
	private JSONObject params;
	private JSONObject fields;
	protected HttpServletRequest httpReq = null;
	protected HttpServletResponse httpResp = null;
	protected OperationMeta operMeta;
	protected VelocityHelper vh = null;

	public OperationHelper(){
		
	}
	
	public OperationHelper(int operId, HttpServletRequest req, HttpServletResponse httpResp) throws Exception{
		this.httpReq = req;
		this.httpResp = httpResp;
		init(operId);
	}
	
	public OperationHelper(int operId, HttpServletRequest req, HttpServletResponse httpResp, VelocityHelper vh) throws Exception{
		this.httpReq = req;
		this.httpResp = httpResp;
		this.vh = vh;
		init(operId);
	}
	
	
	private void init(int operId) throws Exception{
		oper = new JSONObject();
		oper.accumulate("id", String.valueOf(operId));
		operMeta = MetaDataManager.getOperation(operId);
		params = new JSONObject();
		fields = new JSONObject();
		oper.accumulate("parameters", params);
		oper.accumulate("fields", fields);
	}
	
	public void addParameter(String name, Object value) throws Exception{
		if(operMeta.getType() != OperationMeta.SP){
			JSONObject val = new JSONObject();
			val.accumulate("value", value); 
			params.accumulate(name, val);
		}else
			params.accumulate(name, value);
	}

	public void addField(String name, Object value) throws Exception {
		fields.accumulate(name, value);
	}

	public void putField(String name, Object value) throws Exception {
		fields.put(name, value);
	}
	
	
	public IObjectWrapper execOperation() throws Exception{
		return OperationFactory.getOperation(oper, httpReq, httpResp, vh).performOperation();
	}
	
	
	public static void savePendingEmail(String email_to, String from, VelocityHelper vh) throws Exception{
		String body = vh.renderTemplate();
		String subject = vh.getVariable("subject").toString();
		InsertOperationHelper oh = new InsertOperationHelper(42, null, null);
		JSONObject fields = new JSONObject();
		fields.accumulate("recip_to", email_to);
		fields.accumulate("subj", subject);
		fields.accumulate("body", body);
		if(from == null)
			fields.accumulate("from_email", "mailer@upmile.com");
		else
			fields.accumulate("from_email", from);
		oh.addFields(fields);
		oh.execOperation();
	}
	
}
