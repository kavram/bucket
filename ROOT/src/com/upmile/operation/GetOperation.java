package com.upmile.operation;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.upmile.data.IObject;
import com.upmile.data.ObjectImpl;
import com.upmile.meta.OperationMeta;
import com.upmile.util.VelocityHelper;

public class GetOperation extends Operation {
	
	private IObject iobj = null;
	private JSONObject limit = null;
	private JSONObject order = null;
	//private JSONObject params = null;

	public GetOperation(JSONObject obj, OperationMeta om, HttpServletRequest httpReq, HttpServletResponse httpResp) throws Exception {
		super(obj, om, httpReq, httpResp);
		init(obj);
	}

	public GetOperation(JSONObject obj, OperationMeta om, HttpServletRequest httpReq, HttpServletResponse httpResp, VelocityHelper vh) throws Exception {
		super(vh, obj, om, httpReq, httpResp);
		init(obj);
	}

	private void init(JSONObject obj) throws Exception{
		iobj = new ObjectImpl(om.getObj().getName(), this);
		params = obj.getJSONObject("parameters");
		if(obj.has("lt"))
			limit = obj.getJSONObject("lt");
		if(obj.has("order"))
			order = obj.getJSONObject("order");
	}
	
	@Override
	protected void performDataOperation() throws Exception {
		resOW.getObjects().addAll(iobj.restoreFromDb(om, params, limit, order).getObjects());
	}

}
