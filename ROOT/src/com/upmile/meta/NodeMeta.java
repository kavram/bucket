package com.upmile.meta;

import java.util.ArrayList;
import java.util.Collection;

import org.json.JSONObject;



public class NodeMeta {

	public final static int NODE_TYPE_VALUE = 0;
	public final static int NODE_TYPE_REFERENCE = 2;
	public final static int NODE_TYPE_DYNAMIC_REFERENCE = 5;
	public final static int NODE_TYPE_PK = 3;
	public final static int NODE_TYPE_FK = 4;
	public final static int NODE_TYPE_CUSTOM_NODE = 1;
	public final static int NODE_REQUIRED_TRUE = 0;
	public final static int NODE_REQUIRED_FALSE = 1;
	public final static int NODE_CARDINALITY_ONE = 0;
	public final static int NODE_CARDINALITY_MANY = 1;
	public final static int NODE_STATUS_ENABLED = 0;
	public final static int NODE_STATUS_DISABLED = 1;
	
	private int nodeId;
	private ObjectMeta parentObject;
	private int nodeType;
	private int required;
	private int cardinality;
	private int customizable;
	private String nodeName;
	private String dbType;
	private String javaType;
	private String htmlType;
	private String htmlLabel;
	private String dtFormatString;
	private Integer refObjId;
	private String keyField;
	private String refObjKeyField;
	private int status;
	private Collection<RefObjNodeMeta> refObjNodesMeta;
	private Collection<NodeValueMeta> nodeValues;
	
	public NodeMeta(){
		refObjNodesMeta = new ArrayList<RefObjNodeMeta>();
		nodeValues = new ArrayList<NodeValueMeta>();
	}


	public void setNodeValues(Collection<NodeValueMeta> nodeValues){
		this.nodeValues = nodeValues;
	}
	public Collection<NodeValueMeta> getNodeValues(){
		return nodeValues;
	}
	
	
	public void setNodeId(int nodeId){
		this.nodeId = nodeId;
	}
	public void setParentObject(ObjectMeta parentObject){
		this.parentObject = parentObject;
	}
	public void setNodeType(int nodeType){
		this.nodeType = nodeType;
	}
	public void setRequired(int required){
		this.required = required;
	}
	public void setCardinality(int cardinality){
		this.cardinality = cardinality;
	}
	public void setNodeName(String nodeName){
		this.nodeName = nodeName;
	}

	public void setRefObjNodesMeta(Collection<RefObjNodeMeta> col){
		this.refObjNodesMeta = col;
	}

	
	public int getNodeId(){
		return nodeId;
	}
	public ObjectMeta getParentObjectMeta(){
		return parentObject;
	}
	public int getNodeType(){
		return nodeType;
	}
	public boolean isReferenceType(){
		return nodeType == NodeMeta.NODE_TYPE_REFERENCE;
	}
	public int getRequired(){
		return required;
	}
	public int getCardinality(){
		return cardinality;
	}
	public Collection<RefObjNodeMeta> getRefObjNodesMeta(){
		return refObjNodesMeta;
	}

	public void setJavaType(String javaType){
		this.javaType = javaType;
	}
	public String getJavaType(){
		return javaType;
	}
	public void setHtmlType(String htmlType){
		this.htmlType = htmlType;
	}
	public String getHtmlType(){
		return htmlType;
	}
	public void setDbType(String dbType){
		this.dbType = dbType;
	}
	public String getDbType(){
		return dbType;
	}

	public String getDtFormatString(){
		return dtFormatString;
	}
	public void setDtFormatString(String dtFormatString){
		this.dtFormatString = dtFormatString;
	}
	
	public String getNodeName(){
		return nodeName;
	}
	
	public String getDbFieldName(){
		if(nodeType == NodeMeta.NODE_TYPE_REFERENCE)
			return keyField;
		else
			return nodeName;
	}

	public void setKeyField(String keyField) {
		this.keyField = keyField;
	}

	public String getKeyField() {
		return keyField;
	}

	public void setRefObjKeyField(String refObjKeyField) {
		this.refObjKeyField = refObjKeyField;
	}

	public String getRefObjKeyField() {
		return refObjKeyField;
	}

	public void setRefObjId(Integer refObjId) {
		this.refObjId = refObjId;
	}

	public Integer getRefObjId() {
		return refObjId;
	}

	public void getValues(JSONObject jo) throws Exception {
		for(NodeValueMeta nv : nodeValues){
			JSONObject jobj = new JSONObject();
			jobj.accumulate("value", nv.getValue());
			jobj.accumulate("label", nv.getLabel());
			jobj.accumulate("name", nv.getName());
			jo.append("values", jobj);
		}
	}

	public void setCustomizable(int customizable) {
		this.customizable = customizable;
	}


	public int getCustomizable() {
		return customizable;
	}


	public void setHtmlLabel(String htmlLabel) {
		this.htmlLabel = htmlLabel;
	}


	public String getHtmlLabel() {
		return htmlLabel;
	}


	public void setStatus(int status) {
		this.status = status;
	}


	public int getStatus() {
		return status;
	}
	
}
