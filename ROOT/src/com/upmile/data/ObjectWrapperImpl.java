package com.upmile.data;

import java.util.ArrayList;
import java.util.Collection;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;


public class ObjectWrapperImpl implements IObjectWrapper {
	static Logger log = Logger.getLogger(ObjectWrapperImpl.class);
	private Collection<IObject> objects = new ArrayList<IObject>();
	private String renderedHTML;
	
	
	public ObjectWrapperImpl(){
	}
	
	public void addObject(IObject obj){
		objects.add(obj);
	}
	
	public Collection<IObject> getObjects() {
		return objects;
	}
	
	public String serializeObjectsToJSONString() throws Exception{
		JSONArray ja = new JSONArray();
		for(IObject obj : objects){
			//JSONObject jobj = new JSONObject();
			JSONObject jobj = obj.getJSONObj();
			ja.put(jobj);
		}
		return ja.toString();
	}
	
	public void addObjectsToJSONArray(JSONArray ja) throws Exception{
		for(IObject obj : objects){
			ja.put(obj.getJSONObj());
		}
		
	}
	
	public String getRenderedHTML() {
		return renderedHTML;
	}

	public void setRenderedHTML(String renderedHTML) {
		this.renderedHTML = renderedHTML;
	}

	@Override
	public IObject getObject() throws Exception {
		if(objects != null && !objects.isEmpty())
			return (IObject) objects.toArray()[0];
		else
			return null;
	}
	
}
