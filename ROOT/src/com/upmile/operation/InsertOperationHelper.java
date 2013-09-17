package com.upmile.operation;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import com.upmile.meta.MetaDataManager;

public class InsertOperationHelper extends OperationHelper {

	private JSONArray jarFields;
	
	public InsertOperationHelper(int operId, HttpServletRequest req, HttpServletResponse httpResp) throws Exception {
		this.httpReq = req;
		this.httpResp = httpResp;
		oper = new JSONObject();
		jarFields = new JSONArray();
		oper.accumulate("id", String.valueOf(operId));
		operMeta = MetaDataManager.getOperation(operId);
		oper.accumulate("parameters", new JSONObject());
		oper.put("fields", jarFields);
		
	}
	
	public void addFields(JSONObject fields){
		jarFields.put(fields);
	}

}
