package com.upmile.data;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;

import org.apache.log4j.Logger;

import com.upmile.data.DataManager.InsertData;

public class InsertVisitor extends Visitor{
	static Logger log = Logger.getLogger(InsertVisitor.class);
	private InsertData id;
	private Collection<INode> refNodesForInsert = new ArrayList<INode>();
	private String sql;
	private String fields;
	private String values;
	
	public InsertVisitor(String table) throws SQLException{
		DataManager dm = DataManager.getInstance();
		id = dm.getInsertData();
		super.pu = id;
		sql = "insert into " + table + "(";
		fields = "";
		values = "";
	}
	
	public void subscribeRefNodeForInsert(INode node){
		refNodesForInsert.add(node);
	}
	
	public void insertRefNodes() throws Exception{
		for(INode node : refNodesForInsert)
			((ReferenceNodeImpl)node).insert();
	}
	
	public void addNode(SQLParam node){
		if(!fields.isEmpty()){
			fields += ",";
			values += ",";
		}
		fields += node.getFieldName();
		values += "?";
		parameters.put(Integer.valueOf(ind), node);
		ind++;
	}
	
	public long insert() throws Exception {
		sql += fields + ") values (" + values + ")";
		id.prepare(sql);
		for(int i = 1; i < ind; i++){
			SQLParam nd = parameters.get(i);
			setParameter(i, nd);
		}
		log.debug("insert sql: " + sql);
		System.out.println("insert sql: " + sql);
		return id.executeInsertQuery();
		
	}
	
	
}
