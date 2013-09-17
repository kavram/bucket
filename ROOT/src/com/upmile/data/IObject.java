package com.upmile.data;


import java.util.Collection;

import org.json.JSONObject;

import com.upmile.meta.ObjectMeta;
import com.upmile.meta.OperationMeta;


public interface IObject {
	public static final int STALE_OBJECT_STATUS = -2;
	
    public ObjectMeta getObjectMeta();
	public void addINode(INode node);
	public INode getINode(String nodeName) throws Exception;
	public String getNodeValueAsStr(String nodeName) throws Exception;
	public Object getNodeValue(String nodeName) throws Exception;
	public Collection<INode> getINodes();
	public void createNodesFromOperParameters(JSONObject params) throws Exception;
	public void createNodesFromParams(OperationMeta om, JSONObject params) throws Exception;
	public IObject getParent() throws Exception;
	public JSONObject getJSONObj() throws Exception;
	public JSONObject getJSONNodes() throws Exception;
	public void insert() throws Exception;
	public IObjectWrapper restoreFromDb(OperationMeta om, JSONObject parameters, 
			JSONObject limit, JSONObject order) throws Exception;
	public IObjectWrapper restoreFromDb(JSONObject parameters, JSONObject limit) throws Exception;
	//public void delete(JSONObject params) throws Exception;
	public void setOpId(String opId);
}
