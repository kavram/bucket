package com.upmile.data;

import org.apache.log4j.Logger;
import org.json.JSONObject;
import com.upmile.data.DataManager.UpdateData;
import com.upmile.meta.OperationMeta;
import com.upmile.meta.OperationParamMeta;
import com.upmile.operation.Operation;

public class UpdateVisitor extends Visitor{
	static Logger log = Logger.getLogger(UpdateVisitor.class);
	private UpdateData ud;
	private IObject updateObj;
	private IObject whereObj;
	private String sql;
	private String fields = "";
	OperationMeta om;
	
	public UpdateVisitor(OperationMeta om, JSONObject jnodes,  JSONObject jparams, Operation op) throws Exception {
		updateObj = new ObjectImpl(null, om, jnodes, op);
		whereObj = new ObjectImpl(om.getObj().getName(), op);
		whereObj.createNodesFromParams(om, jparams);
		ud = DataManager.getInstance().getUpdateData();
		super.pu = ud;
		sql = "update " + updateObj.getObjectMeta().getDataTable() + " set ";
		this.om = om;
	}

	public IObject getUpdateObj(){
		return updateObj;
	}
	
	private void addNode(IDbNode node) throws Exception{
		if(!fields.isEmpty())
			fields += ",";
		fields += node.getNodeDbFieldName() + " = ?";
		SQLParam sp = new SQLParam(node.getDbNodeValue(), 
				node.getNodeDbFieldName(), node.getNodeDbFieldType());
		parameters.put(Integer.valueOf(ind), sp);
		ind++;
	}
	
	private void prepare() throws Exception{
		for(OperationParamMeta opm : om.getFields()){
			INode node = updateObj.getINode(opm.getNode().getNodeName());
			addNode((IDbNode)node);
		}
		for(OperationParamMeta opm : om.getParams()){
			INode node = whereObj.getINode(opm.getNode().getNodeName());
			((IDbNode)node).setWhereParam(this, false);
		}
		
		sql += fields + " where " + where;
		ud.prepare(sql);
	}
	
	public int update() throws Exception {
		prepare();
		for(int i = 1; i < ind; i++){
			SQLParam sp = parameters.get(i);
			setParameter(i, sp);
		}
		log.debug("update sql: " + sql);
		int num = ud.executeUpdateQuery();
		log.debug("update rows: " + num);
		return num;
		//updateRefNodes();
	}
	
}
