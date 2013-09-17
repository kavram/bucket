package com.upmile.data;

import java.sql.Date;
import java.sql.Time;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Collection;

import org.json.JSONArray;
import org.json.JSONObject;

import com.upmile.meta.DataTypeMeta;
import com.upmile.meta.NodeMeta;

public class PrimitiveNodeImpl implements INode, IDbNode {

	private NodeMeta nm;
	private IObject parentObj;
	private Object value = null;
	private String operand = null;
	private String paramValue = null;
	
	
	public PrimitiveNodeImpl(NodeMeta nm, IObject parentObj, Object value){
		this.nm = nm;
		this.parentObj = parentObj;
		this.value = value;
	}

	public PrimitiveNodeImpl(NodeMeta nm, IObject parentObj, Object value, String operand){
		this.nm = nm;
		this.parentObj = parentObj;
		this.value = value;
		this.operand = operand;
	}
	
	public PrimitiveNodeImpl(IObject parentObj, NodeMeta nm, String nodeValue) throws Exception{
		this.parentObj = parentObj;
		this.nm = nm;
		createNodeFromStringValue(nodeValue);
	}

	public PrimitiveNodeImpl(IObject parentObj, NodeMeta nm, String paramValue, String operand) throws Exception{
		this.parentObj = parentObj;
		this.nm = nm;
		this.operand = operand;
		this.paramValue = paramValue;
	}
	
	
	public PrimitiveNodeImpl(IObject parentObj, NodeMeta nm) throws Exception{
		this.parentObj = parentObj;
		this.nm = nm;
	}
	
	public Object getValue(){
		return value;
	}
	
	public void setValue(Object value) throws Exception{
		this.value = value; 
	}
	
	public void setParentObject(IObject parent){
		parentObj = parent;
	}
	
	private void setValue(String value) throws Exception{
		this.value = createValue(value);
	}
	
	private Object createValue(String value) throws Exception{
		value = value.trim();
		if(value.isEmpty())
			return null;
		Object ret = null;
		String type = "";
		type = nm.getJavaType();
		if(type.equals(DataTypeMeta.JAVA_TYPE_INTEGER)){
			Integer val = new Integer(value);
			ret = val;
		}if(type.equals(DataTypeMeta.JAVA_TYPE_LONG)){
			Long val = new Long(value);
			ret = val;
		}else if(type.equals(DataTypeMeta.JAVA_TYPE_DECIMAL)){
			Float val = new Float(value);
			ret = val;
		}else if(type.equals(DataTypeMeta.JAVA_TYPE_STRING) || type.equals(DataTypeMeta.JAVA_TYPE_TEXT))
			ret = value;
		else if(type.equals(DataTypeMeta.JAVA_TYPE_JSON_ARRAY))
			ret = new JSONArray(value);
		else if(type.equals(DataTypeMeta.JAVA_TYPE_JSON_OBJ))
			ret = new JSONObject(value);
		else if(type.equals(DataTypeMeta.JAVA_TYPE_DATE)){
			SimpleDateFormat df = new SimpleDateFormat(nm.getDtFormatString());
			java.util.Date date = df.parse(value);
			Date d = new Date(date.getTime());
			ret = d;
		}else if(type.equals(DataTypeMeta.JAVA_TYPE_TIME)){
			SimpleDateFormat df = new SimpleDateFormat(nm.getDtFormatString());
			java.util.Date date = df.parse(value);
			Time t = new Time(date.getTime());
			ret = t;
		}else if(type.equals(DataTypeMeta.JAVA_TYPE_DATE_TIME)){
			SimpleDateFormat df = new SimpleDateFormat(nm.getDtFormatString());
			java.util.Date date = df.parse(value);
			ret = date;
		}else if(type.equals(DataTypeMeta.PADDED_PIPE_SEPARATED_STR)){
			PaddedPipeSeparatedStr pps = new PaddedPipeSeparatedStr(value);
			ret = pps;
		}
		return ret;
	}
	
	private void createNodeFromStringValue(String value) throws Exception{
		if(value != null && !value.isEmpty())
			setValue(value);
	}
	
	public NodeMeta getNodeMeta(){
		return nm;
	}

	public Collection<IObject> getObjectValue() throws Exception {
		return null;
	}
	
	
	public IObject getParentIObject() {
		return parentObj;
	}

	//public Object getPrimitiveValue() {
	//	return value;
	//}

	public void insertVisit(InsertVisitor iv) throws Exception {
		if(value == null && nm.getNodeType() == NodeMeta.NODE_TYPE_FK)
			value = parentObj.getINode(nm.getRefObjKeyField()).getValue();
		if(value == null || nm.getNodeName().equals("id"))
			return;
		SQLParam sp = null;
		if(value != null){
			sp = new SQLParam(getDbNodeValue(), nm.getNodeName(), getNodeDbFieldType());
		}else if(value == null && nm.getRequired() == NodeMeta.NODE_REQUIRED_FALSE)
			sp = new SQLParam(null, nm.getNodeName(), getNodeDbFieldType());
		iv.addNode(sp);

	}

	public Object getDbNodeValue() {
		return value;
	}

	public String getNodeDbFieldName() {
		return nm.getNodeName();
	}

	public String getNodeDbFieldType() {
		return nm.getJavaType();
	}

	public void addToJSON(JSONObject jobj) throws Exception {
		if(value != null){
			if(nm.getJavaType().equals(DataTypeMeta.JAVA_TYPE_TIME) ||
					nm.getJavaType().equals(DataTypeMeta.JAVA_TYPE_DATE) ||
					nm.getJavaType().equals(DataTypeMeta.JAVA_TYPE_DATE_TIME)){
				if(nm.getDtFormatString() != null){
					SimpleDateFormat df = new SimpleDateFormat(nm.getDtFormatString());
					jobj.accumulate(nm.getNodeName(), df.format(value));
				}else	
					jobj.accumulate(nm.getNodeName(), DateFormat.getTimeInstance(DateFormat.SHORT).format(value));
			}else if(nm.getJavaType().equals(DataTypeMeta.JAVA_TYPE_JSON_OBJ)){
				jobj.accumulate(nm.getNodeName(), value);
			}else if(nm.getJavaType().equals(DataTypeMeta.JAVA_TYPE_JSON_ARRAY)){
				jobj.put(nm.getNodeName(), value);
			}else
				jobj.accumulate(nm.getNodeName(), value.toString());
		}else
			jobj.accumulate(nm.getNodeName(), JSONObject.NULL);
	}

	public void deleteVisit(DeleteVisitor dv) throws Exception {
		// TODO Auto-generated method stub
		
	}

	public void setWhereParam(Visitor sv, boolean objAnnotate) throws Exception {
		String whereClouse = "";
		String param = objAnnotate? nm.getParentObjectMeta().getName() + "." + 
				nm.getNodeName() :	nm.getNodeName();
		if(paramValue != null){
			String[] vals = paramValue.split(",");
			for(int i = 0; i < vals.length; i++){
				Object val = createValue(vals[i]);
				SQLParam wp = new SQLParam(val, nm.getNodeName(), nm.getJavaType());
				sv.addWhereParam(wp);
				if(whereClouse.length() > 0)
					whereClouse += " or ";
				whereClouse += param + operand + "?";
			}
			if(vals.length > 1)
				whereClouse = "(" + whereClouse + ")";
			sv.addWhereClause(whereClouse);
		}else if(value != null){
			SQLParam wp = new SQLParam(value, nm.getNodeName(), nm.getJavaType());
			sv.addWhereParam(wp);
			whereClouse += param + operand + "?";
			sv.addWhereClause(whereClouse);
		}
	}

	public void createNodesFromGetParameters(JSONArray jsonArray)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

	public void createNodesFromGetParameters(JSONObject json) throws Exception {
		// TODO Auto-generated method stub
		
	}

	public String getNodeOperand() {
		return operand;
	}

	public Collection<IObject> getIObjectValue() {
		// TODO Auto-generated method stub
		return null;
	}

	public Object getSQLParamValue() throws Exception {
		if(paramValue == null)
			return null;
		else
			return createValue(paramValue);
	}

}
