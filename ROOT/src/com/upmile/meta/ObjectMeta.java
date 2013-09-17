package com.upmile.meta;

import java.util.HashMap;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;


public class ObjectMeta {

	public final int CUSTOM_NODES_ALLOWED = 1;
	public final int CUSTOM_NODES_NOT_ALLOWED = 0;
	
	private int id;
	private String name;
	private String dataTable;
	private int customNodesAllowed;
	private Map<String, NodeMeta> nodes;
	private Map<Integer, NodeMeta> nodesById;
	private Map<String, NodeMeta> nodesByDBField;
	private Map<Integer, Map<Integer, UserCustomNodeMeta>> customNodes;
	
	public ObjectMeta(){
		nodes = new HashMap<String, NodeMeta>();
		nodesById = new HashMap<Integer, NodeMeta>();
		customNodes = new HashMap<Integer, Map<Integer, UserCustomNodeMeta>>();
		setNodesByDBField(new HashMap<String, NodeMeta>());
	}
	
	public JSONObject getNodesMeta(JSONArray jnodes, int ownerId) throws Exception{
		Map<Integer, UserCustomNodeMeta> map = customNodes.get(ownerId);
		//JSONArray onodes = new JSONArray();
		for(int i = 0; i < jnodes.length(); i++) {
			NodeMeta nm = nodes.get(jnodes.getString(i));
			JSONObject jnode = new JSONObject();
			JSONObject jo = new JSONObject();
			UserCustomNodeMeta cnm = null;
			if(map != null && map.containsKey(nm.getNodeId()))
				cnm = map.get(nm.getNodeId());
			if(cnm != null && cnm.getStatus() == NodeMeta.NODE_STATUS_ENABLED){
				jo.accumulate("nt", nm.getNodeType());
				//jo.accumulate("name", nm.getNodeName());
				jo.accumulate("ht", nm.getHtmlType());
				if(cnm.getNodeLabel() != null && !cnm.getNodeLabel().isEmpty())
					jo.accumulate("label", cnm.getNodeLabel());
				else if(nm.getHtmlLabel() != null && !nm.getHtmlLabel().isEmpty())
					jo.accumulate("label", nm.getHtmlLabel());
				jnode.accumulate("node", nm.getNodeName());
				jnode.accumulate("props", jo);
				jnodes.put(jnode);
			}else{
				JSONObject nd = getNodeMeta(nm);
				if(nd != null)
					jnodes.put(nd);
			}
		}
		if(map != null){
			for(UserCustomNodeMeta ucn : map.values()){
				if(ucn.getNodeMeta().getNodeType() == NodeMeta.NODE_TYPE_CUSTOM_NODE){
					JSONObject jo = new JSONObject();
					JSONObject jnode = new JSONObject();
					jo.accumulate("nt", ucn.getNodeMeta().getNodeType());
					//jo.accumulate("name", ucn.getNodeMeta().getNodeName());
					jo.accumulate("label", ucn.getNodeLabel());
					jo.accumulate("ht", ucn.getNodeMeta().getHtmlType());
					jnode.accumulate("node", ucn.getNodeMeta().getNodeName());
					jnode.accumulate("props", jo);
					jnodes.put(jnode);
				}
			}
		}
		JSONObject jonodes = new JSONObject();
		jonodes.accumulate("on", name);
		jonodes.accumulate("nodes", jnodes);
		return jonodes;
	}

	public JSONObject getNodesMeta(JSONArray jnodes) throws Exception{
		JSONObject ret = new JSONObject();
		ret.accumulate("on", name);
		for(int i = 0; i < jnodes.length(); i++) {
			NodeMeta nm = nodes.get(jnodes.getString(i));
			JSONObject nd = getNodeMeta(nm);
			if(nd != null)
				ret.accumulate("nodes", nd);
			
		}
		return ret;
	}
	
	
	public JSONObject getNodeMeta(NodeMeta nm) throws Exception{
		JSONObject node = new JSONObject();
		JSONObject props = new JSONObject();
		props.accumulate("nt", nm.getNodeType());
		props.accumulate("label", nm.getHtmlLabel());
		props.accumulate("ht", nm.getHtmlType());
		if(nm.getNodeType() == NodeMeta.NODE_TYPE_REFERENCE)
			props.accumulate("ref", MetaDataManager.getObjectMeta(nm.getRefObjId()).getAllNodesMeta());
		if(!nm.getNodeValues().isEmpty())
			nm.getValues(props);
		node.accumulate("name", nm.getNodeName());
		node.accumulate("props", props);
		return node;
	}
	
	
	public JSONArray getAllNodesMeta() throws Exception{
		JSONArray ja = new JSONArray();
		for(NodeMeta nm : nodes.values()){
			ja.put(getNodeMeta(nm));
		}
		return ja;
	}
	
	
	public void setId(int id){
		this.id = id;
	}
	public void setName(String name){
		this.name = name;
	}
	public void setDataTable(String dataTable){
		this.dataTable = dataTable;
	}

	
	public int getId(){
		return this.id;
	}
	public String getName(){
		return this.name;
	}
	public String getDataTable(){
		return this.dataTable;
	}
	public Map<String, NodeMeta> getNodes(){
		return this.nodes;
	}
	
	public NodeMeta getNodeMeta(String name){
		return nodes.get(name);
	}

	public void setNodesByDBField(Map<String, NodeMeta> nodesByDBField) {
		this.nodesByDBField = nodesByDBField;
	}

	public Map<String, NodeMeta> getNodesByDBField() {
		return nodesByDBField;
	}

	public NodeMeta getNodeMetaByDBField(String name){
		return nodesByDBField.get(name);
	}

	public void setCustomNodes(Map<Integer, Map<Integer, UserCustomNodeMeta>> customNodes) {
		this.customNodes = customNodes;
	}

	public Map<Integer, Map<Integer, UserCustomNodeMeta>> getCustomNodes() {
		return customNodes;
	}

	public void setCustomNodesAllowed(int customNodesAllowed) {
		this.customNodesAllowed = customNodesAllowed;
	}

	public int getCustomNodesAllowed() {
		return customNodesAllowed;
	}

	public void setNodesById(Map<Integer, NodeMeta> nodesById) {
		this.nodesById = nodesById;
	}

	public Map<Integer, NodeMeta> getNodesById() {
		return nodesById;
	}

}
