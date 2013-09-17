package com.upmile.meta;


public class UserCustomNodeMeta{
	
	private int id;
	private int ownerId;
	private String nodeLabel;
	private NodeMeta nodeMeta;
	private int status;
	
	public UserCustomNodeMeta(){}
	
	public void setId(int id) {
		this.id = id;
	}
	public int getId() {
		return id;
	}
	public void setOwnerId(int ownerId) {
		this.ownerId = ownerId;
	}
	public int getOwnerId() {
		return ownerId;
	}

	public void setNodeLabel(String nodeLabel) {
		this.nodeLabel = nodeLabel;
	}

	public String getNodeLabel() {
		return nodeLabel;
	}

	public void setNodeMeta(NodeMeta nodeMeta) {
		this.nodeMeta = nodeMeta;
	}

	public NodeMeta getNodeMeta() {
		return nodeMeta;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getStatus() {
		return status;
	}
	
}
