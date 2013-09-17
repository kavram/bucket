package com.upmile.data;

import org.apache.log4j.Logger;
import org.json.JSONObject;

import com.upmile.data.DataManager.UpdateData;
import com.upmile.meta.OperationMeta;
import com.upmile.meta.OperationParamMeta;
import com.upmile.operation.Operation;

public class DeleteVisitor extends Visitor{
	static Logger log = Logger.getLogger(DeleteVisitor.class);
	
	private UpdateData ud;
//	private Collection<INode> refNodesForDelete = new ArrayList<INode>();
	private String sql;
	private IObject whereObj;
	OperationMeta om;
	
	public DeleteVisitor(OperationMeta om, JSONObject jparams, Operation op) throws Exception {
		whereObj = new ObjectImpl(om.getObj().getName(), null);
		whereObj.createNodesFromParams(om, jparams);
		ud = DataManager.getInstance().getUpdateData();
		super.pu = ud;
		sql = "delete from " + om.getObj().getDataTable() + " where ";
		this.om = om;

	}

	private void prepare() throws Exception{
		for(OperationParamMeta opm : om.getParams()){
			INode node = whereObj.getINode(opm.getNode().getNodeName());
			((IDbNode)node).setWhereParam(this, false);
		}
		sql += where;
		ud.prepare(sql);
	}
	
	
	public int delete() throws Exception {
		prepare();
		ud.prepare(sql);
		for(int i = 1; i < ind; i++){
			SQLParam wp = parameters.get(i);
			setParameter(i, wp);
		}
		log.debug("delete sql: " + sql);
		return ud.executeUpdateQuery();
	}
	
}
