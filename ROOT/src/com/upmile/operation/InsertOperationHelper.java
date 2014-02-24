package com.upmile.operation;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import com.upmile.meta.MetaDataManager;

public class InsertOperationHelper extends OperationHelper {

	private JSONArray jarFields;
	
	public InsertOperationHelper(int operId, HttpServletRequest req, HttpServletResponse httpResp) throws Exception {
		super(operId, req, httpResp);
		jarFields = new JSONArray();
		oper.remove("fields");
		oper.put("fields", jarFields);
		
	}
	
	public void addFields(JSONObject fields){
		jarFields.put(fields);
	}

}
