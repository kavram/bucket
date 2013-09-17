package com.upmile.operation;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import com.upmile.data.IObject;
import com.upmile.data.ObjectImpl;
import com.upmile.meta.OperationMeta;

public class InsertOperation extends Operation {

		
	public InsertOperation(JSONObject jobj, OperationMeta om, HttpServletRequest httpReq, HttpServletResponse httpResp) throws Exception {
		super(jobj, om, httpReq, httpResp);
		JSONArray jar = jobj.getJSONArray("fields");
		for(int i = 0; i < jar.length(); i++){
			objColl.add(new ObjectImpl(null, om, jar.getJSONObject(i), this));
		}
	}

	@Override
	protected void performDataOperation() throws Exception {
		for(IObject obj : objColl){
			obj.insert();
			resOW.addObject(obj);
		}
	}

}
