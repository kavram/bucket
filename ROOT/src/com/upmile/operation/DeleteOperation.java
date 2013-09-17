package com.upmile.operation;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.upmile.data.DeleteVisitor;
import com.upmile.meta.OperationMeta;

public class DeleteOperation extends Operation {
	private DeleteVisitor dv;

	public DeleteOperation(JSONObject obj, OperationMeta om, HttpServletRequest httpReq, HttpServletResponse httpResp)	throws Exception {
		super(obj, om, httpReq, httpResp);
		dv = new DeleteVisitor(om, obj.getJSONObject("parameters"), this);
	}

	@Override
	protected void performDataOperation() throws Exception {
		dv.delete();
	}

}
