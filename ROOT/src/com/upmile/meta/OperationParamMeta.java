package com.upmile.meta;

import java.util.List;


public class OperationParamMeta {

	public final static int FIELD = 0;
	public final static int PARAM = 1;
	public final static int SP_PARAM = 2;
	public final static int VALUE_TYPE_CLIENT = 0;
	public final static int VALUE_TYPE_SESSION = 1;
	public final static int VALUE_TYPE_UUID = 2;
	public final static int VALUE_TYPE_META = 3;
	public final static int VALUE_TYPE_CURRENT_DATE = 4;
	public final static int VALUE_TEMP_PASSWORD = 5;
	public final static int REQUIRED = 0;
	public final static int NOT_REQUIRED = 1;
	
	private int id;
	private int paramType;
	private int valueType;
	private int required;
	private String value;
	private NodeMeta node;
	private SpParameterMeta spParam;
	private List<OperationParamMeta> refOperParamMeta;
	private String operand;
	private String[] sessionValue;
	
	public OperationParamMeta() {
		
	}
	
	public void setId(int id) {
		this.id = id;
	}

	public int getId() {
		return id;
	}

	public void setParamType(int paramType) {
		this.paramType = paramType;
	}

	public int getParamType() {
		return paramType;
	}

	public void setValueType(int valueType) {
		this.valueType = valueType;
	}

	public int getValueType() {
		return valueType;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getValue() {
		return value;
	}

	public void setNode(NodeMeta node) {
		this.node = node;
	}

	public NodeMeta getNode() {
		return node;
	}

	public void setSpParam(SpParameterMeta spParam) {
		this.spParam = spParam;
	}

	public SpParameterMeta getSpParam() {
		return spParam;
	}

	public void setRefOperParamMeta(List<OperationParamMeta> refOperParamMeta) {
		this.refOperParamMeta = refOperParamMeta;
	}

	public List<OperationParamMeta> getRefOperParamMeta() {
		return refOperParamMeta;
	}

	public void setOperand(String operand) {
		this.operand = operand;
	}

	public String getOperand() {
		return operand;
	}

	public String[] getSessionValue() {
		return sessionValue;
	}

	public void setSessionValue(String[] sessionValue) {
		this.sessionValue = sessionValue;
	}

	public int getRequired() {
		return required;
	}

	public void setRequired(int required) {
		this.required = required;
	}
}
