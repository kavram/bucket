package com.upmile.meta;

public class ObjectCustomFieldsMeta {

	private int id;
	private int objId;
	private String fieldName;
	private String fieldDbType;
	private int fieldDataLength;
	
	public ObjectCustomFieldsMeta() {}
	
	public void setId(int id) {
		this.id = id;
	}
	public int getId() {
		return id;
	}
	public void setObjId(int objId) {
		this.objId = objId;
	}
	public int getObjId() {
		return objId;
	}
	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}
	public String getFieldName() {
		return fieldName;
	}
	public void setFieldDbType(String fieldDbType) {
		this.fieldDbType = fieldDbType;
	}
	public String getFieldDbType() {
		return fieldDbType;
	}
	public void setFieldDataLength(int fieldDataLength) {
		this.fieldDataLength = fieldDataLength;
	}
	public int getFieldDataLength() {
		return fieldDataLength;
	}
	
}
