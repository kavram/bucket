package com.upmile.data;


import java.util.Collection;

import org.json.JSONArray;
import org.json.JSONObject;

import com.upmile.meta.NodeMeta;


public interface INode {

	public IObject getParentIObject();
	public NodeMeta getNodeMeta();
	public Object getValue();
	public Object getSQLParamValue() throws Exception;
	public Collection<IObject> getIObjectValue();
	public void setValue(Object value) throws Exception;
	public void addToJSON(JSONObject jobj) throws Exception;
	public void createNodesFromGetParameters(JSONArray jsonArray) throws Exception;
	public void createNodesFromGetParameters(JSONObject json) throws Exception;

}
