package com.upmile.meta;


import org.json.JSONObject;

public class DataTypeMeta {

	public final static String JAVA_TYPE_STRING = "String";
	public final static String JAVA_TYPE_INTEGER = "Integer";
	public final static String JAVA_TYPE_LONG = "Long";
	public final static String JAVA_TYPE_DATE = "Date";
	public final static String JAVA_TYPE_TIME = "Time";
	public final static String JAVA_TYPE_DATE_TIME = "Timestamp";
	public final static String JAVA_TYPE_TEXT = "Text";
	public final static String JAVA_TYPE_DECIMAL = "BigDecimal";
	public final static String JAVA_TYPE_JSON_OBJ = "JSONObject";
	public final static String JAVA_TYPE_JSON_ARRAY = "JSONArray";
	public final static String PADDED_PIPE_SEPARATED_STR = "PaddedPipeSeparatedStr";
	
	
	private int id;
	private String name;
	private String description;
	private String dbType;
	private String javaType;
	private String formatString;
	
	public DataTypeMeta(){
		
	}

	public JSONObject getJsonObject() throws Exception{
		JSONObject json = new JSONObject();
		json.accumulate("id", String.valueOf(id));
		json.accumulate("name", name);
		json.accumulate("description", description);
		return json;
	}
	
	public void setId(int id){	
		this.id = id;
	}
	public void setName(String name){
		this.name = name;
	}
	public void setDbType(String dbType){
		this.dbType = dbType;
	}
	public void setJavaType(String javaType){
		this.javaType = javaType;
	}
	public void setFormatString(String formatString){
		this.formatString = formatString;
	}

	
	public int getId(){	
		return id;
	}
	public String getName(){
		return name;
	}
	public String getDbType(){
		return dbType;
	}
	public String getJavaType(){
		return javaType;
	}
	public String getFormatString(){
		return formatString;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getDescription() {
		return description;
	}
	
	
}
