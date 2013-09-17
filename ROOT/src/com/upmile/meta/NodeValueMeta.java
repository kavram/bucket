package com.upmile.meta;

import org.json.JSONObject;

public class NodeValueMeta {

	private int id;
	private String name;
	private String value;
	private String label;
	
	public NodeValueMeta(){
		
	}

	
	public JSONObject getJsonObject() throws Exception{
		JSONObject json = new JSONObject();
		json.accumulate("name", value);
		json.accumulate("value", value);
		json.accumulate("label", label);
		return json;
	}
	
	public void setId(int id){
		this.id = id;
	}
	public void setName(String name){
		this.name = name;
	}
	public void setValue(String value){
		this.value = value;
	}
	public void setLabel(String label){
		this.label = label;
	}

	public int getId(){
		return id;
	}
	public String getName(){
		return name;
	}
	public String getValue(){
		return value;
	}
	public String getLabel(){
		return label;
	}
	
}
