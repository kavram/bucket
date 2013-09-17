package com.upmile.data;

import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.apache.log4j.Logger;
import org.json.JSONObject;

import com.upmile.meta.MetaDataManager;
import com.upmile.meta.NodeMeta;
import com.upmile.meta.ObjectMeta;
import com.upmile.meta.OperationMeta;
import com.upmile.meta.OperationParamMeta;
import com.upmile.operation.Operation;


public class ObjectImpl implements IObject {
	static Logger log = Logger.getLogger(ObjectImpl.class);
	private ObjectMeta om;
	private Map<String, INode> nodes = new HashMap<String, INode>();
	private IObject parentObj = null;
	private String opId = "";
	private Operation op;
	
	public ObjectImpl(String objName, Operation op) throws Exception{
		this.om = MetaDataManager.getObjectMeta(objName);
		this.op = op;
	}

	public ObjectImpl(IObject parent, OperationMeta om, JSONObject jsonObj, Operation op) throws Exception{
		this.om = om.getObj();
		this.parentObj = parent;
		this.op = op;
		IObject pt = parentObj == null ? this : parentObj;
		for(OperationParamMeta opm : om.getFields()){
			INode node = null;
			if(opm.getNode().getNodeType() == NodeMeta.NODE_TYPE_REFERENCE){
				if(opm.getNode().getCardinality() == NodeMeta.NODE_CARDINALITY_MANY)
					node = new ReferenceNodeImpl(pt, opm, jsonObj.getJSONArray(opm.getNode().getNodeName()), op);
				else
					node = new ReferenceNodeImpl(pt, opm, jsonObj.getJSONObject(opm.getNode().getNodeName()), op);
			}else{
					String value = null;
					if(opm.getValueType() == OperationParamMeta.VALUE_TYPE_CLIENT){
						if(opm.getRequired() == OperationParamMeta.REQUIRED)
							value = jsonObj.getString(opm.getNode().getNodeName());
						else
							if(jsonObj.has(opm.getNode().getNodeName()))
								value = jsonObj.getString(opm.getNode().getNodeName());
					}else
						value = op.getValue(opm);
					node = new PrimitiveNodeImpl(pt, opm.getNode(), value);
			}
			nodes.put(opm.getNode().getNodeName(), node);
			
		}
		
	}
	
	public ObjectImpl(IObject parent, String objName) throws Exception{
		this.parentObj = parent;
		this.om = MetaDataManager.getObjectMeta(objName);
	}
	
	public ObjectImpl(IObject pnt, OperationParamMeta opm, JSONObject json, Operation op) throws Exception {
		this.parentObj = pnt;
		this.op = op;
		this.om = MetaDataManager.getObjectMeta(opm.getNode().getNodeName());
		createNodes(opm, json);
	}

	private void createNodes(OperationParamMeta opm, JSONObject json) throws Exception {
		for(OperationParamMeta nodeOpm : opm.getRefOperParamMeta()){
			createNode(nodeOpm, json);
		}
		
	}

	private void createNode(OperationParamMeta opm, JSONObject json) throws Exception {
		INode node = null;
		IObject parent = parentObj == null ? this : parentObj;
		if(opm.getNode().getNodeType() == NodeMeta.NODE_TYPE_REFERENCE){
			if(opm.getNode().getCardinality() == NodeMeta.NODE_CARDINALITY_MANY)
				node = new ReferenceNodeImpl(parent, opm, json.getJSONArray(opm.getNode().getNodeName()), op);
			else
				node = new ReferenceNodeImpl(parent, opm, json.getJSONObject(opm.getNode().getNodeName()), op);
		}else{
			if(opm.getNode().getNodeType() == NodeMeta.NODE_TYPE_FK)
				node = new PrimitiveNodeImpl(parent, opm.getNode());
			else{
				String value = null;
				if(opm.getValueType() == OperationParamMeta.VALUE_TYPE_CLIENT){
					if(opm.getRequired() == OperationParamMeta.REQUIRED)
						value = json.getString(opm.getNode().getNodeName());
					else
						if(json.has(opm.getNode().getNodeName()))
							value = json.getString(opm.getNode().getNodeName());
				}else
					value = op.getValue(opm);
				node = new PrimitiveNodeImpl(parent, opm.getNode(), value);
			}
		}
		nodes.put(opm.getNode().getNodeName(), node);
	}

	public void setOpId(String opId){
		this.opId = opId;
	}
	
	private void createNodeFromGetParameter(NodeMeta nm, JSONObject jsonNodes) throws Exception{
		INode node = null;
		IObject parent = parentObj == null ? this : parentObj;
		if(nm.getNodeType() == NodeMeta.NODE_TYPE_REFERENCE){
			node = new ReferenceNodeImpl(parent, nm);
			if(nm.getCardinality() == NodeMeta.NODE_CARDINALITY_MANY)
				node.createNodesFromGetParameters(jsonNodes.getJSONArray(nm.getNodeName()));
			else
				node.createNodesFromGetParameters(jsonNodes.getJSONObject(nm.getNodeName()));
		}else{
			JSONObject jNode = jsonNodes.getJSONObject(nm.getNodeName());
			node = new PrimitiveNodeImpl(parent, nm, getParameterValue(nm, jNode), jNode.getString("op"));
		}
		nodes.put(nm.getNodeName(), node);
	}
	
	private String getParameterValue(NodeMeta nm, JSONObject jobj) throws Exception{
		String val = "";
		//if(jobj.getString("value").equals("#uid"))
		//	val = userId.toString();
		//else
			val = jobj.getString("value");
		return val;
	}
	
	public void createNodesFromOperParameters(JSONObject params) throws Exception{
		Iterator<String> iter = params.keys();
		while(iter.hasNext()){
			String nodeName = iter.next();
			NodeMeta nm = om.getNodeMeta(nodeName);
			createNodeFromGetParameter(nm, params);
		}
	}
	
	
	public void insert() throws Exception {
		InsertVisitor iv = new InsertVisitor(om.getDataTable());
		for(Map.Entry<String, INode> entry : nodes.entrySet()){
			INode node = entry.getValue();
			((IDbNode)node).insertVisit(iv);
		}
		long id = iv.insert();
		INode idNode = new PrimitiveNodeImpl(this, om.getNodeMeta("id"), String.valueOf(id));
		nodes.put(idNode.getNodeMeta().getNodeName(), idNode);
		iv.insertRefNodes();
	}
	
	public IObject getParent() throws Exception {
		return parentObj;
	}
	
	
	public JSONObject getJSONNodes() throws Exception {
		JSONObject jobj = new JSONObject();
		for(INode node : nodes.values()){
			if(node.getNodeMeta().getNodeType() != NodeMeta.NODE_TYPE_REFERENCE)
				node.addToJSON(jobj);
			else{
				for(IObject io : node.getIObjectValue()){
					jobj.append(node.getNodeMeta().getNodeName(), io.getJSONNodes());
				}
			}
		}
		return jobj;
	}
	
	public JSONObject getJSONObj() throws Exception{
		JSONObject jobj = new JSONObject();
		JSONObject jnodes = new JSONObject();
		jobj.accumulate("object", om.getName());
		if(!opId.isEmpty())
			jobj.accumulate("opid", opId);
		for(INode node : nodes.values()){
			if(node.getNodeMeta().getNodeType() != NodeMeta.NODE_TYPE_REFERENCE)
				node.addToJSON(jnodes);
			else{
				for(IObject io : node.getIObjectValue()){
					jnodes.append(node.getNodeMeta().getNodeName(), io.getJSONNodes());
				}
			}
		}
		jobj.accumulate("nodes", jnodes);
		return jobj;
	}
	
	
	public void addINode(INode node){
		nodes.put(node.getNodeMeta().getNodeName(), node);
	}
	
	public ObjectMeta getObjectMeta() {
		return om;
	}

	public INode getINode(String nodeName) throws Exception {
		if(nodes.containsKey(nodeName))
			return (INode)nodes.get(nodeName);
		else
			return null;
	}

/*	
	public void delete(JSONObject params) throws Exception {
		//if(!nodes.containsKey("id") || nodes.get("id").getPrimitiveValue() == null)
		//	return;
		//IDbNode id = (IDbNode)nodes.get("id");
		//SQLParam sp = new SQLParam(id.getDbNodeValue(), id.getNodeDbFieldName(), id.getNodeDbFieldType());
		createNodesFromOperParameters(params);
		DeleteVisitor dv = new DeleteVisitor(om.getDataTable());
		for(INode node : nodes.values())
			((IDbNode)node).setWhereParam(dv, false);
		int rows = dv.delete();
		log.debug("deleted rows: " + rows);
		dv.deleteRefNodes();
	}
*/
	public IObjectWrapper restoreFromDb(JSONObject parameters, JSONObject limit) throws Exception {
		createNodesFromOperParameters(parameters);
		SelectVisitor sv = new SelectVisitor(om, null, limit);
		for(NodeMeta nm : om.getNodes().values())
			sv.addField(nm);
		
		for(INode node : nodes.values())
			((IDbNode)node).setWhereParam(sv, true);

		sv.select();
		return sv.getResults(om.getName());
	}

	public Collection<INode> getINodes() {
		return nodes.values();
	}

	public void createNodesFromParams(OperationMeta om, JSONObject params) throws Exception{
		for(OperationParamMeta opm : om.getParams()){
			createNodeFromParam(opm, params);
		}
		
	}
	
	private void createNodeFromParam(OperationParamMeta opm, JSONObject params) throws Exception {
		INode node = null;
		IObject parent = parentObj == null ? this : parentObj;
		if(opm.getNode().getNodeType() == NodeMeta.NODE_TYPE_REFERENCE){
			node = new ReferenceNodeImpl(parent, opm.getNode());
			if(opm.getNode().getCardinality() == NodeMeta.NODE_CARDINALITY_MANY)
				node.createNodesFromGetParameters(params.getJSONArray(opm.getNode().getNodeName()));
			else
				node.createNodesFromGetParameters(params.getJSONObject(opm.getNode().getNodeName()));
		}else{
			String value = null;
			String operand = null;
			if(opm.getValueType() == OperationParamMeta.VALUE_TYPE_CLIENT){
				value = getParameterValue(opm.getNode(), params.getJSONObject(opm.getNode().getNodeName()));
			}else
				value = op.getValue(opm);
			if(opm.getOperand() != null)
				operand = opm.getOperand();
			else {
				JSONObject jNode = params.getJSONObject(opm.getNode().getNodeName());
				operand = jNode.getString("op");
			}
			node = new PrimitiveNodeImpl(parent, opm.getNode(), value, operand);
		}
		nodes.put(opm.getNode().getNodeName(), node);
	}

	@Override
	public IObjectWrapper restoreFromDb(OperationMeta om, JSONObject jobj, JSONObject limit, JSONObject order) throws Exception {
		createNodesFromParams(om, jobj);
		SelectVisitor sv = new SelectVisitor(om.getObj(), order, limit);
		for(OperationParamMeta opm : om.getFields())
			sv.addField(opm.getNode());
		
		for(INode node : nodes.values())
			((IDbNode)node).setWhereParam(sv, true);

		sv.select();
		return sv.getResults(om.getObj().getName());
	}

	@Override
	public String getNodeValueAsStr(String nodeName) throws Exception {
		if(nodes.containsKey(nodeName))
			return nodes.get(nodeName).getValue().toString();
		else
			return null;
	}

	@Override
	public Object getNodeValue(String nodeName) throws Exception {
		if(nodes.containsKey(nodeName))
			return nodes.get(nodeName).getValue();
		else
			return null;
	}
	
	
}
