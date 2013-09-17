package com.upmile.operation;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.upmile.meta.MetaDataManager;
import com.upmile.meta.OperationMeta;
import com.upmile.util.VelocityHelper;

public class OperationFactory {

	public static Operation getOperation(JSONObject jobj, HttpServletRequest httpReq, HttpServletResponse httpResp, VelocityHelper vh) throws Exception{
		Operation oper = null;
		
		Integer id = jobj.getInt("id");
		OperationMeta om = MetaDataManager.getOperation(id);
		if(om.getType() == OperationMeta.INSERT)
			oper = new InsertOperation(jobj, om, httpReq, httpResp);
		else if(om.getType() == OperationMeta.SP)
			oper = new SpOperation(jobj, om, httpReq, httpResp, vh);
		else if(om.getType() == OperationMeta.UPDATE)
			oper = new UpdateOperation(jobj, om, httpReq, httpResp);
		else if(om.getType() == OperationMeta.GET)
			oper = new GetOperation(jobj, om, httpReq, httpResp, vh);
		else if(om.getType() == OperationMeta.DELETE)
			oper = new DeleteOperation(jobj, om, httpReq, httpResp);
		
		return oper;
	}
	
}
