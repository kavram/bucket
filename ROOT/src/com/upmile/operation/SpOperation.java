package com.upmile.operation;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.mysql.jdbc.exceptions.MySQLTransactionRollbackException;
import com.upmile.data.DataManager;
import com.upmile.data.DataManager.ExecStoredProc;
import com.upmile.meta.MetaDataManager;
import com.upmile.meta.NodeMeta;
import com.upmile.meta.ObjectMeta;
import com.upmile.meta.OperationMeta;
import com.upmile.meta.OperationParamMeta;
import com.upmile.util.VelocityHelper;

public class SpOperation extends Operation {

	public SpOperation(JSONObject obj, OperationMeta om, HttpServletRequest httpReq, HttpServletResponse httpResp) throws Exception {
		super(obj, om, httpReq, httpResp);
		params = obj.getJSONObject("parameters");
	}

	public SpOperation(JSONObject obj, OperationMeta om, HttpServletRequest httpReq, HttpServletResponse httpResp, VelocityHelper vh) throws Exception {
		super(vh, obj, om, httpReq, httpResp);
		params = obj.getJSONObject("parameters");
	}
	
	
	@Override
	protected void performDataOperation() throws MySQLTransactionRollbackException, Exception {
		ExecStoredProc esp = DataManager.getInstance().getExecStoredProc();
		esp.exec(om, params, this);
		if(om.getSp().getResultObjectId() != 0){
			ObjectMeta objm = MetaDataManager.getObjectMeta(om.getSp().getResultObjectId());
			Map<String, NodeMeta> map = new HashMap<String, NodeMeta>();
			for(OperationParamMeta opm : om.getFields()){
				map.put(opm.getNode().getNodeName(), opm.getNode());
			}
			resOW.getObjects().addAll(esp.getOperationResults(objm, map).getObjects());
		}
	}

}
