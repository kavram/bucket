package com.upmile.data;

import java.util.ArrayList;
import java.util.Collection;
import org.json.JSONArray;
import org.json.JSONObject;

import com.upmile.meta.MetaDataManager;
import com.upmile.meta.NodeMeta;
import com.upmile.meta.ObjectMeta;
import com.upmile.meta.OperationParamMeta;
import com.upmile.meta.RefObjNodeMeta;
import com.upmile.operation.Operation;

public class ReferenceNodeImpl implements INode, IDbNode {

	private NodeMeta nm;
	private IObject parentObj;
	private Collection<IObject> collValue = new ArrayList<IObject>();
	private NodeMeta refObjKeyNodeMeta;
	private ObjectMeta refObj = null;
	private Object keyFieldValue = null;
	private Operation op;
	
	public ReferenceNodeImpl(IObject parentObj, NodeMeta nm, IObject val){
		this.parentObj = parentObj;
		this.nm = nm;
		this.refObjKeyNodeMeta = MetaDataManager.getObjectMeta(nm.getRefObjId()).getNodeMeta(nm.getRefObjKeyField());
		this.refObj = MetaDataManager.getObjectMeta(nm.getRefObjId());
		this.collValue.add(val);
	}
	
	public ReferenceNodeImpl(IObject parentObj, NodeMeta nm) {
		this.parentObj = parentObj;
		this.nm = nm;
		this.refObjKeyNodeMeta = MetaDataManager.getObjectMeta(nm.getRefObjId()).getNodeMeta(nm.getRefObjKeyField());
		this.refObj = MetaDataManager.getObjectMeta(nm.getRefObjId());
	}

	public ReferenceNodeImpl(IObject parentObj, NodeMeta nm, Object keyFieldValue) {
		this.parentObj = parentObj;
		this.nm = nm;
		this.refObjKeyNodeMeta = MetaDataManager.getObjectMeta(nm.getRefObjId()).getNodeMeta(nm.getRefObjKeyField());
		this.refObj = MetaDataManager.getObjectMeta(nm.getRefObjId());
		this.keyFieldValue = keyFieldValue;
	}
	
	public ReferenceNodeImpl(IObject pt, OperationParamMeta opm, JSONArray jsonArray, Operation op) throws Exception {
		this.parentObj = pt;
		this.nm = opm.getNode();
		this.refObjKeyNodeMeta = MetaDataManager.getObjectMeta(nm.getRefObjId()).getNodeMeta(nm.getRefObjKeyField());
		this.refObj = MetaDataManager.getObjectMeta(nm.getRefObjId());
		this.op = op;
		createNodeFromJSONArray(opm, jsonArray);
	}

	public ReferenceNodeImpl(IObject pt, OperationParamMeta opm, JSONObject jObj, Operation op) throws Exception {
		this.parentObj = pt;
		this.nm = opm.getNode();
		this.refObjKeyNodeMeta = MetaDataManager.getObjectMeta(nm.getRefObjId()).getNodeMeta(nm.getRefObjKeyField());
		this.refObj = MetaDataManager.getObjectMeta(nm.getRefObjId());
		this.op = op;
		createNodeFromJSONObject(opm, jObj);
		IObject refObj = (IObject)collValue.toArray()[0];
		keyFieldValue = refObj.getINode(nm.getRefObjKeyField()).getValue();
	}

	public void restoreFromDB() throws Exception{
		if(keyFieldValue != null)
			restoreByKeyField();
		else
			restoreByFKeyField();
	}
	
	private void restoreByKeyField() throws Exception{
		SelectVisitor sv = new SelectVisitor(refObj, null, null);
		for(RefObjNodeMeta ron : nm.getRefObjNodesMeta()){
			NodeMeta nm = refObj.getNodeMeta(ron.getNodeName());
			sv.addField(nm);
		}
		INode keyNode = new PrimitiveNodeImpl(refObjKeyNodeMeta, parentObj, keyFieldValue, "=");
		((IDbNode)keyNode).setWhereParam(sv, true);
		sv.select();
		collValue = sv.getResults(refObj.getName()).getObjects();
	}
	
	private void restoreByFKeyField() throws Exception{
		SelectVisitor sv = new SelectVisitor(refObj, null, null);
		if(nm.getRefObjNodesMeta() != null && !nm.getRefObjNodesMeta().isEmpty()){
			for(RefObjNodeMeta ron : nm.getRefObjNodesMeta()){
				NodeMeta nm = refObj.getNodeMeta(ron.getNodeName());
				addFieldtoSV(sv, nm);
			}			
		}else {
			for(NodeMeta nm : refObj.getNodes().values()){      
				addFieldtoSV(sv, nm);
			}
		}
		sv.select();
		collValue = sv.getResults(refObj.getName()).getObjects();
	}
	
	private void addFieldtoSV(SelectVisitor sv, NodeMeta nm) throws Exception{
		if(nm.getNodeType() == NodeMeta.NODE_TYPE_FK){                            
			INode fKeyNode = new PrimitiveNodeImpl(nm, parentObj, 
					parentObj.getINode(nm.getRefObjKeyField()).getValue(), "=");
			((IDbNode)fKeyNode).setWhereParam(sv, true);
		}else
			sv.addField(nm);		
	}
	
	public void setValue(Object value) throws Exception{
	}
	
	public void setParentObject(IObject parent){
		parentObj = parent;
	}
	
	private void createNodeFromJSONObject(OperationParamMeta opm, JSONObject json) throws Exception{
		IObject obj = new ObjectImpl(parentObj, opm, json, op);
		collValue.add(obj);
	}

	private void createNodeFromJSONArray(OperationParamMeta opm, JSONArray json) throws Exception{
		for(int i = 0; i < json.length(); i++){
			JSONObject jsonObj = json.getJSONObject(i);
			IObject obj = new ObjectImpl(parentObj, opm, jsonObj, op);
			collValue.add(obj);
		}
	}
	
	public void createNodesFromGetParameters(JSONArray json) throws Exception{
		for(int i = 0; i < json.length(); i++){
			JSONObject jsonObj = json.getJSONObject(i);
			IObject obj = new ObjectImpl(parentObj, refObj.getName());
			obj.createNodesFromOperParameters(jsonObj);
			collValue.add(obj);
		}
		
	}
	
	public NodeMeta getNodeMeta(){
		return nm;
	}

	public Collection<IObject> getIObjectValue() {
		return collValue;
	}
	
	
	public IObject getParentIObject() {
		return parentObj;
	}

	public Object getValue() {
		// TODO Auto-generated method stub
		return null;
	}

	public void insertVisit(InsertVisitor iv) throws Exception {
		if(nm.getKeyField() == null)
			iv.subscribeRefNodeForInsert(this);
		else if(getDbNodeValue() != null){
			SQLParam sp = new SQLParam(getDbNodeValue(), getNodeDbFieldName(), getNodeDbFieldType());
			iv.addNode(sp);
		}
	}

	public void insert() throws Exception{
		for(IObject obj : collValue)
			obj.insert();
	}
	
	public Object getDbNodeValue() throws Exception {
		return keyFieldValue;
	}

	public String getNodeDbFieldName() {
		return nm.getKeyField();
	}

	public String getNodeDbFieldType() {
		return refObjKeyNodeMeta.getJavaType();
	}

	public void addToJSON(JSONObject jobj) throws Exception {
	}

/*	
	@Override
	public void updateVisit(UpdateVisitor uv) throws Exception {
		if(!collValue.isEmpty())
			uv.subscribeRefNodeForUpdate(this);
		
	}

	public void update() throws Exception {
		for(IObject obj : collValue)
			obj.update();
	}
*/
	public void delete() throws Exception {
		//for(IObject obj : collValue)
		//	obj.delete();
	}

	public void deleteVisit(DeleteVisitor dv) throws Exception {
//		if(!collValue.isEmpty())
//			dv.subscribeRefNodeForDelete(this);
	}

	private void setWhereParamByKeyField(Visitor sv) throws Exception{
		String whereClause = " ";
		IObject obj = (IObject)collValue.toArray()[0];
		INode in = obj.getINode(nm.getRefObjKeyField());
		whereClause = nm.getKeyField() + ((IDbNode)in).getNodeOperand() + "?";
		SQLParam wp = new SQLParam(in.getSQLParamValue(), 
				nm.getKeyField(), ((IDbNode)in).getNodeDbFieldType());
		sv.addWhereParam(wp);
		sv.addWhereClause(whereClause);
	}
	
	private void setWhereParamByRefObj(Visitor sv) throws Exception {
		String whereClause = " ";
		String params = "";
		for(NodeMeta nm : refObj.getNodes().values()){
			if(nm.getNodeType() == NodeMeta.NODE_TYPE_FK){
				whereClause += nm.getRefObjKeyField() + " in (select " + nm.getDbFieldName() +
				" from " + refObj.getDataTable() + " where ";
			}
		}
		IObject obj = (IObject)collValue.toArray()[0];
		for(INode inode : obj.getINodes()){
			if(inode.getNodeMeta().getNodeType() == NodeMeta.NODE_TYPE_VALUE){
				if(params.length() > 0)
					params += " and ";
				params += ((IDbNode)inode).getNodeDbFieldName() +
				((IDbNode)inode).getNodeOperand() + "?";
				SQLParam wp = new SQLParam(inode.getSQLParamValue(), 
						((IDbNode)inode).getNodeDbFieldName(), ((IDbNode)inode).getNodeDbFieldType());
				sv.addWhereParam(wp);
			}else if(inode.getNodeMeta().isReferenceType() 
					&& inode.getNodeMeta().getKeyField() != null){
				IObject ro = (IObject)inode.getIObjectValue().toArray()[0];
				INode io = ro.getINode(inode.getNodeMeta().getRefObjKeyField());
				if(params.length() > 0)
					params += " and ";
				params += inode.getNodeMeta().getKeyField() +
				((IDbNode)io).getNodeOperand() + "?";
				SQLParam wp = new SQLParam(io.getSQLParamValue(), 
						((IDbNode)io).getNodeDbFieldName(), ((IDbNode)io).getNodeDbFieldType());
				sv.addWhereParam(wp);
			}
		}
		whereClause += params + " )";
		sv.addWhereClause(whereClause);
	}
	
	public void setWhereParam(Visitor sv, boolean objAnnotate) throws Exception {
		if(nm.getKeyField() == null){
			setWhereParamByRefObj(sv);
		}else{
			setWhereParamByKeyField(sv);
		}
	}

	public void createNodesFromGetParameters(JSONObject json) throws Exception {
		IObject obj = new ObjectImpl(parentObj, refObj.getName());
		obj.createNodesFromOperParameters(json);
		collValue.add(obj);
	}

	public String getNodeOperand() {
		// TODO Auto-generated method stub
		return null;
	}

	public Object getSQLParamValue() throws Exception{
		// TODO Auto-generated method stub
		return null;
	}

}
