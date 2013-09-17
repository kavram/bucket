package com.upmile.data;

public interface IDbNode {

	public void insertVisit(InsertVisitor iv) throws Exception;
	public String getNodeDbFieldName();
	public String getNodeDbFieldType();
	public String getNodeOperand();
	public Object getDbNodeValue() throws Exception;
	public void deleteVisit(DeleteVisitor dv) throws Exception;
	public void setWhereParam(Visitor sv, boolean objAnnotate) throws Exception;
}
