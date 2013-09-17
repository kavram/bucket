package com.upmile.data;

import java.util.Collection;

import org.json.JSONArray;


public interface IObjectWrapper {

	public Collection<IObject> getObjects();
	public void addObject(IObject obj);
	public String serializeObjectsToJSONString() throws Exception;
	public String getRenderedHTML();
	public void setRenderedHTML(String renderedHTML);
	public void addObjectsToJSONArray(JSONArray ja) throws Exception;
	public IObject getObject() throws Exception;
}
