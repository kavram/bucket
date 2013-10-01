package com.upmile.persistence;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.concurrent.ConcurrentHashMap;

import javax.sql.DataSource;

import org.apache.log4j.Logger;

public class ConnectionFactory {
	static Logger log = Logger.getLogger(ConnectionFactory.class);

	private static ConcurrentHashMap<Long, Connection> connections; 
	private static ConnectionFactory _instance;
	private DataSource dataSource;
	
	
	public static void close() throws Exception{
		for(Connection cw : connections.values()){
			cw.close();
		}
	}

	
	public ConnectionFactory(){
		
	}
	
	public static ConnectionFactory getInstance(){
		return _instance;
		
	}
	
	public void init(){
		_instance = this;
		connections = new ConcurrentHashMap<Long, Connection>();
	}

	private Connection createConnection() throws SQLException{
		Long threadId = new Long(Thread.currentThread().getId());
		Connection cw = null;
		if(!connections.containsKey(threadId)){
			cw = dataSource.getConnection();
			cw.setAutoCommit(false);
			connections.put(threadId, cw);
		}
		return cw;
	}

	public static Connection getConnection() throws SQLException{
		Long threadId = new Long(Thread.currentThread().getId());
		Connection cn = null;
		if(connections.containsKey(threadId))
			cn = (Connection)connections.get(threadId);
		else{
			cn = _instance.createConnection();
		}
		log.debug("get connection id: " + cn.hashCode() + " thread id: " + threadId);
		return cn;
	}
	
	public void commitAndReleaseConn(){
		Long threadId = new Long(Thread.currentThread().getId());
		Connection cn = (Connection)connections.get(threadId);
		try{
			if(cn != null){
				log.debug("commit on connection id: " + cn.hashCode() +	" thread id: " + threadId);
				cn.commit();
				connections.remove(threadId);
			}
			//cn.close();
		}catch(Exception e){
			log.error(e.getMessage(), e);
		}
	}

	
	public void commit(){
		Long threadId = new Long(Thread.currentThread().getId());
		Connection cn = (Connection)connections.get(threadId);
		try{
			log.debug("commit on connection id: " + cn.hashCode() +	" thread id: " + threadId);
			cn.commit();
		}catch(Exception e){
			log.error(e.getMessage(), e);
		}
	}

	public void rollbackAndReleaseConn(){
		Long threadId = new Long(Thread.currentThread().getId());
		Connection cn = (Connection)connections.get(threadId);
		try{
			if(cn != null){
				log.debug("rollback on connection id: " + cn.hashCode() + " thread id: " + threadId);
				cn.rollback();
				connections.remove(threadId);
			}
			//cn.close();
		}catch(Exception e){
			log.error(e.getMessage(), e);
		}
	}

	public void rollback(){
		Long threadId = new Long(Thread.currentThread().getId());
		Connection cn = (Connection)connections.get(threadId);
		try{
			log.debug("rollback on connection id: " + cn.hashCode() + " thread id: " + threadId);
			cn.rollback();
		}catch(Exception e){
			log.error(e.getMessage(), e);
		}
	}
	
	public DataSource getDataSource() {
		return dataSource;
	}

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}
	
	
}
