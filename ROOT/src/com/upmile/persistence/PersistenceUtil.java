package com.upmile.persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Time;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;

import com.mysql.jdbc.exceptions.MySQLTransactionRollbackException;
import com.upmile.data.INode;
import com.upmile.data.IObject;
import com.upmile.data.IObjectWrapper;
import com.upmile.data.ObjectImpl;
import com.upmile.data.ObjectWrapperImpl;
import com.upmile.data.PaddedPipeSeparatedStr;
import com.upmile.data.PrimitiveNodeImpl;
import com.upmile.data.ReferenceNodeImpl;
import com.upmile.meta.DataTypeMeta;
import com.upmile.meta.MetaDataManager;
import com.upmile.meta.NodeMeta;
import com.upmile.meta.ObjectMeta;
import com.upmile.meta.RefObjNodeMeta;
import com.upmile.meta.SpParameterMeta;

public abstract class PersistenceUtil {
	static Logger log = Logger.getLogger(PersistenceUtil.class);
	protected Connection dbConnection;
	protected Statement stmt;
	protected CallableStatement callStmt;
	protected ResultSet rs;
	protected PreparedStatement prepStmt;
	private Collection<ReferenceNodeImpl> refNodes = new ArrayList<ReferenceNodeImpl>();

	
	protected PersistenceUtil() throws SQLException{
		init();
	}
	
	private void init() throws SQLException{
	    	dbConnection = ConnectionFactory.getConnection();
	}

	protected void prepareStoredProcCall(String sql) throws Exception{
		callStmt = dbConnection.prepareCall(sql);
	}
	
	protected void prepareInsertStatement(String sql) throws Exception {
		prepStmt = dbConnection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
	}

	protected void prepareStatement(String sql) throws Exception {
		prepStmt = dbConnection.prepareStatement(sql);
	}
	
	protected void setStoredProcParameter(SpParameterMeta spm, String value) throws Exception{
		if(value == null)
			setNullValueParam(spm.getParameterName(), spm.getParameterSqlType());
		else if(spm.getParameterType().equals(SpParameterMeta.PARAM_TYPE_STRING))
			setStringParameter(spm.getParameterName(), value.toString());
		else if(spm.getParameterType().equals(SpParameterMeta.PARAM_TYPE_INT))
			setIntegerParameter(spm.getParameterName(), Integer.getInteger(value));
		else if(spm.getParameterType().equals(SpParameterMeta.PARAM_TYPE_LONG))
			setLongParameter(spm.getParameterName(), new Long(value));
		else if(spm.getParameterType().equals(SpParameterMeta.PARAM_TYPE_FLOAT))
			setFloatParameter(spm.getParameterName(), new Float(value));
		else if(spm.getParameterType().equals(SpParameterMeta.PARAM_TYPE_DATE)){
			SimpleDateFormat df = new SimpleDateFormat(spm.getFormatString());
			java.util.Date date = df.parse(value);
			Date d = new Date(date.getTime());
//			log.debug("date: " + d.toString());
			setDateParameter(spm.getParameterName(), d);
		}else if(spm.getParameterType().equals(SpParameterMeta.PARAM_TYPE_TIME)){
			SimpleDateFormat df = new SimpleDateFormat(spm.getFormatString());
			java.util.Date date = df.parse(value);
			Time t = new Time(date.getTime());
//			log.debug("time: " + t.toString());
			setTimeParameter(spm.getParameterName(), t);
		}
	}
	
	private void setStringParameter(String paramName, String paramValue) throws Exception{
		callStmt.setString(paramName, paramValue);
	}
	private void setIntegerParameter(String paramName, Integer paramValue) throws Exception{
		callStmt.setInt(paramName, paramValue.intValue());
	}
	private void setLongParameter(String paramName, Long paramValue) throws Exception{
		callStmt.setLong(paramName, paramValue.intValue());
	}
	private void setFloatParameter(String paramName, Float paramValue) throws Exception{
		callStmt.setFloat(paramName, paramValue.floatValue());
	}
	private void setDateParameter(String paramName, Date paramValue) throws Exception{
		callStmt.setDate(paramName, paramValue);
	}
	private void setTimeParameter(String paramName, Time paramValue) throws Exception{
		callStmt.setTime(paramName, paramValue);
	}
	private void setNullValueParam(String paramName, int paramSqlType) throws Exception{
		callStmt.setNull(paramName, paramSqlType);
	}

	public void setString(int index, String value) throws Exception{
		prepStmt.setString(index, value);
	}
	public void setInteger(int index, Integer value) throws Exception{
		prepStmt.setInt(index, value.intValue());
	}
	public void setLong(int index, Long value) throws Exception{
		prepStmt.setLong(index, value.longValue());
	}
	public void setFloat(int index, Float value) throws Exception{
		prepStmt.setFloat(index, value.floatValue());
	}
	public void setDate(int index, Date value) throws Exception{
		prepStmt.setDate(index, value);
	}
	public void setTime(int index, Time value) throws Exception{
		prepStmt.setTime(index, value);
	}
	public void setTimestamp(int index, Timestamp value) throws Exception{
		prepStmt.setTimestamp(index, value);
	}
	public void setNullParameter(int index, int sqlType) throws Exception{
		prepStmt.setNull(index, sqlType);
	}
	public void setText(int index, String value) throws Exception{
		prepStmt.setBytes(index, value.getBytes());
	}
	
	
	protected void executeQuery() throws SQLException{
		rs = prepStmt.executeQuery();
	}
	
	protected void executeStoredProc() throws MySQLTransactionRollbackException, Exception {
		rs = callStmt.executeQuery();
	}
	
	protected void cleanup() throws Exception{
		if(rs != null)
			rs.close();
		if(callStmt != null)
			callStmt.close();
		log.debug("closed rs and stmt, conn id: " + dbConnection.hashCode() +
				" thread id: " + Thread.currentThread().getId());
	}

	protected String prepareStoredProcSQL(String spName, int paramNum){
		String sqlCall = "{call " + spName + "(";
		for(int i = 0; i < paramNum; i++){
			sqlCall += "?";
			if(i < paramNum - 1)
				sqlCall += ",";
		}
		sqlCall +=")}";
		return sqlCall;
	}
	
	protected IObjectWrapper getResults(ObjectMeta resObj, Map<String, NodeMeta> resNodes) throws Exception{
		log.debug("Object name: " + resObj.getName());
		IObjectWrapper objWrapper = new ObjectWrapperImpl();
		Collection<ReferenceNodeImpl> rnodes = new ArrayList<ReferenceNodeImpl>();
		if(rs == null)
			return objWrapper;
		while(rs.next()){
			refNodes.clear();
			IObject io = new ObjectImpl(resObj.getName(), null);
			for(Entry<String, NodeMeta>	en : resNodes.entrySet()){
				if(!en.getValue().isReferenceType()){
					INode node = createNode(io, en.getValue(), en.getKey());
					io.addINode(node);
				}else if(en.getValue().isReferenceType() && 
				  en.getValue().getCardinality() == NodeMeta.NODE_CARDINALITY_ONE){
					ObjectMeta refObjMeta = MetaDataManager.getObjectMeta(en.getValue().getRefObjId());
					IObject refObj = new ObjectImpl(refObjMeta.getName(), null);
					rnodes.clear();
					for(RefObjNodeMeta rom : en.getValue().getRefObjNodesMeta()){
						NodeMeta refNm = refObjMeta.getNodeMeta(rom.getNodeName());
						if(!refNm.isReferenceType()){
							INode refNode = createNode(refObj, refNm, refObjMeta.getName() + refNm.getNodeName());
							refObj.addINode(refNode);
						}else if(refNm.isReferenceType() && 
							refNm.getCardinality() == NodeMeta.NODE_CARDINALITY_MANY){
							INode node = new ReferenceNodeImpl(refObj, refNm);
							rnodes.add((ReferenceNodeImpl)node);
							refObj.addINode(node);
						}
					}
					for(ReferenceNodeImpl refn : rnodes){
						refn.restoreFromDB();
					}
					INode rn = new ReferenceNodeImpl(io, en.getValue(), refObj);
					io.addINode(rn);
				}else if(en.getValue().isReferenceType() && 
				  en.getValue().getCardinality() == NodeMeta.NODE_CARDINALITY_MANY){
					INode node = new ReferenceNodeImpl(io, en.getValue());
					refNodes.add((ReferenceNodeImpl)node);
					io.addINode(node);
				}
			}
			for(ReferenceNodeImpl rn : refNodes){
				rn.restoreFromDB();
			}
			objWrapper.addObject(io);
		}
		return objWrapper;
	}

	private INode createNode(IObject parent, NodeMeta nm, String field) throws Exception{
		String javaType = nm.getJavaType();
		Object value = null;
		INode in = null;
		if(javaType.equals(DataTypeMeta.JAVA_TYPE_JSON_OBJ)){
			String strVal = rs.getString(field);
			value = new JSONObject(strVal);
		}else if(javaType.equals(DataTypeMeta.JAVA_TYPE_JSON_ARRAY)){
			String strVal = rs.getString(field);
			value = new JSONArray(strVal);
		}else if(javaType.equals(DataTypeMeta.JAVA_TYPE_STRING))
			value = rs.getString(field);
		else if(javaType.equals(DataTypeMeta.JAVA_TYPE_TEXT)){
			byte[] bytes = rs.getBytes(field);
			value = new String(bytes);
		}else if(javaType.equals(DataTypeMeta.JAVA_TYPE_INTEGER))
			value = rs.getInt(field);
		else if(javaType.equals(DataTypeMeta.JAVA_TYPE_LONG))
			value = rs.getLong(field);
		else if(javaType.equals(DataTypeMeta.JAVA_TYPE_DECIMAL))
			value = rs.getFloat(field);		
		else if(javaType.equals(DataTypeMeta.JAVA_TYPE_DATE))
			value = rs.getDate(field);
		else if(javaType.equals(DataTypeMeta.JAVA_TYPE_TIME))
			value = rs.getTime(field);
		else if(javaType.equals(DataTypeMeta.JAVA_TYPE_DATE_TIME))
				value = (java.util.Date)rs.getTimestamp(field);
		else if(javaType.equals(DataTypeMeta.PADDED_PIPE_SEPARATED_STR))
			value = new PaddedPipeSeparatedStr(rs.getString(field));

		if(nm.isReferenceType()){
			in = new ReferenceNodeImpl(parent, nm, value);
			refNodes.add((ReferenceNodeImpl)in);
		}else
			in = new PrimitiveNodeImpl(nm, parent, value);
		
		return in;
		
	}
	
	
}
