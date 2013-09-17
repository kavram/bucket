package com.upmile.data;

public class SQLParam {

	private String fieldName;
	private String fieldType;
	private Object	 paramValue;
	
	public SQLParam(Object value, String fieldName, String fieldType){
		this.fieldName = fieldName;
		this.fieldType = fieldType;
		this.paramValue = value;
	}
	
	public String getFieldName(){
		return fieldName;
	}
	public String getFieldType(){
		return fieldType;
	}
	public Object getParamValue(){
		return paramValue;
	}
}
