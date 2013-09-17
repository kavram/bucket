package com.upmile.data;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.json.JSONObject;

import com.upmile.data.DataManager.SelectData;
import com.upmile.meta.DataTypeMeta;
import com.upmile.meta.MetaDataManager;
import com.upmile.meta.NodeMeta;
import com.upmile.meta.ObjectMeta;
import com.upmile.meta.RefObjNodeMeta;

public class SelectVisitor extends Visitor{
	static Logger log = Logger.getLogger(SelectVisitor.class);
	private SelectData sd;
	private Map<String, NodeMeta> resultFields = new HashMap<String, NodeMeta>();
	private String sql = "select ";
	private String fields = "";
	private JSONObject order = null;
	private JSONObject limit = null;

	
	public SelectVisitor(ObjectMeta om, JSONObject order, JSONObject limit) throws SQLException{
		DataManager dm = DataManager.getInstance();
		sd = dm.getSelectData();
		super.pu = sd;
		super.om = om;
		this.order = order;
		this.limit = limit;
		super.from = " from " + om.getDataTable() + " " + om.getName();
	}
	
	public void addField(NodeMeta nm){
	//	if(resultFields.containsKey(nm.getNodeName()))
	//	    return;
		if(nm.isReferenceType() && nm.getCardinality() == NodeMeta.NODE_CARDINALITY_ONE){
			ObjectMeta refObj = MetaDataManager.getObjectMeta(nm.getRefObjId());
			for(RefObjNodeMeta ron : nm.getRefObjNodesMeta()){
				NodeMeta refNodeMeta = refObj.getNodeMeta(ron.getNodeName());
				if(!refNodeMeta.isReferenceType()){
					addSelectField(refObj.getName() + "." + ron.getNodeName() + 
							" as " + refObj.getName() + ron.getNodeName());
				}
			}
			resultFields.put(nm.getNodeName(), nm);
			from += " inner join " + refObj.getDataTable() + " " + refObj.getName() + " on ";
			from += om.getName() + "." + nm.getKeyField() + "=";
			from += refObj.getName() + "." + nm.getRefObjKeyField();
		}else if(nm.isReferenceType() && nm.getCardinality() == NodeMeta.NODE_CARDINALITY_MANY){
			if(nm.getKeyField() != null){
				addSelectField(nm.getKeyField());
				resultFields.put(nm.getNodeName(), nm);
			}else if(nm.getKeyField() == null){
				resultFields.put(nm.getNodeName(), nm);
			}
		}else {
			addSelectField(om.getName() + "." + nm.getNodeName() + " as " + 
			om.getName() + nm.getNodeName());
			resultFields.put(om.getName() + nm.getNodeName(), nm);
		}
		
	}
	
	private void addSelectField(String field){
		if(!fields.isEmpty())
			fields += ",";
		fields += field;
	}

	public void select() throws Exception {
		if(fields.isEmpty())
			return;
		sql += fields + " " + from + " where " + where;
		if(order != null){
			sql += " order by " + om.getName() + "." + order.getString("fd") + " " + 
			order.getString("dr");
		}
		if(limit != null){
			sql += " limit ?, ?";
			SQLParam sp = new SQLParam(Integer.decode(limit.getString("os")), 
					"offset", DataTypeMeta.JAVA_TYPE_INTEGER);
			addWhereParam(sp);
			SQLParam ct = new SQLParam(Integer.decode(limit.getString("ct")), 
					"count", DataTypeMeta.JAVA_TYPE_INTEGER);
			addWhereParam(ct);
		}
		log.debug("sql: " + sql);
		//System.out.println("sql: " + sql);
		sd.prepare(sql);
		for(int i = 1; i < ind; i++){
			SQLParam wp = parameters.get(i);
			setParameter(i, wp);
		}
		sd.executeSelectQuery();
	}

	public IObjectWrapper getResults(String objName) throws Exception{
		ObjectMeta om = MetaDataManager.getObjectMeta(objName);
		IObjectWrapper wrap = sd.getData(om, resultFields);
		return wrap;
	}
	
	
}
