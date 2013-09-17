package com.upmile.meta;

import java.util.Map;



public class SpMeta {

	private int id;
	private String spName;
	private int resultObjectId;
	private Map<String, SpParameterMeta> spParameters;
	private Map<Integer, SpParameterMeta> spParamsById;
	
	public SpMeta(){}
	
	public void setId(int id){
		this.id = id;
	}
	public void setSpName(String spName){
		this.spName = spName;
	}
	public void setResultObjectId(int resultObjectId){
		this.resultObjectId = resultObjectId;
	}
	public void setSpParameters(Map<String, SpParameterMeta> spParameters){
		this.spParameters = spParameters;
	}
	public void setSpParamsById(Map<Integer, SpParameterMeta> spParams){
		this.spParamsById = spParams;
	}

	public int getId(){
		return id;
	}
	public String getSpName(){
		return spName;
	}
	public int getResultObjectId(){
		return resultObjectId;
	}
	public Map<String, SpParameterMeta> getSpParameters(){
		return spParameters;
	}
	public SpParameterMeta getParamById(int paramId){
		return spParamsById.get(paramId);
	}
}
