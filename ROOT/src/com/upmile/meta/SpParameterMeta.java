package com.upmile.meta;


public class SpParameterMeta {

	public static String PARAM_TYPE_STRING = "varchar";
	public static String PARAM_TYPE_LONG = "bigint";
	public static String PARAM_TYPE_INT = "int";
	public static String PARAM_TYPE_FLOAT = "float";
	public static String PARAM_TYPE_DATE = "date";
	public static String PARAM_TYPE_TIME = "time";
	
	private int id;
	private String parameterName;
	private String parameterType;
	private String formatString;
	private int parameterSqlType;
	
	public SpParameterMeta(){
		
	}

	public void setId(int id){
		this.id = id;
	}
	public void setParameterName(String parameterName){
		this.parameterName = parameterName;
	}
	public void setParameterType(String parameterType){
		this.parameterType = parameterType;
	}
	public void setFormatString(String formatString){
		this.formatString = formatString;
	}
	public void setParameterSqlType(int parameterSqlType){
		this.parameterSqlType = parameterSqlType;
	}

	public int getId(){
		return id;
	}
	public String getParameterName(){
		return parameterName;
	}
	public String getParameterType(){
		return parameterType;
	}
	public int getParameterSqlType(){
		return parameterSqlType;
	}
	public String getFormatString(){
		return formatString;
	}

}
