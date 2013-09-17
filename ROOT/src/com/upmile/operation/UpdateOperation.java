package com.upmile.operation;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.upmile.data.UpdateVisitor;
import com.upmile.meta.OperationMeta;

public class UpdateOperation extends Operation {
	private UpdateVisitor uv;
	
	public UpdateOperation(JSONObject obj, OperationMeta om, HttpServletRequest httpReq, HttpServletResponse httpResp) throws Exception {
		super(obj, om, httpReq, httpResp);
		uv = new UpdateVisitor(om, obj.getJSONObject("fields"), obj.getJSONObject("parameters"), this);
	}

	@Override
	protected void performDataOperation() throws Exception {
		uv.update();
		resOW.addObject(uv.getUpdateObj());
	}

}
