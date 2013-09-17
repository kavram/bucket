package com.upmile.meta;

public class RefObjNodeMeta {

	private int id;
	private String nodeName;
	private String permission;

	
	public RefObjNodeMeta() {}
	
	public void setId(int id) {
		this.id = id;
	}
	public int getId() {
		return id;
	}
	public void setNodeName(String nodeName) {
		this.nodeName = nodeName;
	}
	public String getNodeName() {
		return nodeName;
	}
	public void setPermission(String permission) {
		this.permission = permission;
	}
	public String getPermission() {
		return permission;
	}
}
