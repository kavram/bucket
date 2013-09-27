package com.upmile.persistence;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.log4j.Logger;

public class ConnectionFactory {
	static Logger log = Logger.getLogger(ConnectionFactory.class);

	private static ConcurrentHashMap<Long, ConnectionWrapper> connections; 
	private static ConnectionFactory _instance;
	
	public static void close() throws Exception{
		for(ConnectionWrapper cw : connections.values()){
			cw.getConn().close();
		}
	}
	
	public ConnectionFactory(){
	}
	
	public static ConnectionFactory getInstance(){
		return _instance;
		
	}

	public void init() {
		connections = new ConcurrentHashMap<Long, ConnectionWrapper>();
		_instance = this;
	}	
	
	private void createConnection() throws SQLException{
		Long threadId = new Long(Thread.currentThread().getId());
		ConnectionWrapper cw = null;
		if(!connections.containsKey(threadId)){
			cw = new ConnectionWrapper();
			connections.put(threadId, cw);
		}
	}

	public static Connection getConnection() throws SQLException{
		Long threadId = new Long(Thread.currentThread().getId());
		Connection cn = null;
		if(connections.containsKey(threadId))
			cn = ((ConnectionWrapper)connections.get(threadId)).getConn();
		else{
			_instance.createConnection();
			cn = getConnection();
		}
		log.debug("get connection id: " + cn.hashCode() + " thread id: " + threadId);

		return cn;
	}
	
	public void commitAndReleaseConn(){
		Long threadId = new Long(Thread.currentThread().getId());
		Connection cn = ((ConnectionWrapper)connections.get(threadId)).getConn();
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
		Connection cn = ((ConnectionWrapper)connections.get(threadId)).getConn();
		try{
			log.debug("commit on connection id: " + cn.hashCode() +	" thread id: " + threadId);
			cn.commit();
		}catch(Exception e){
			log.error(e.getMessage(), e);
		}
	}

	public void rollbackAndReleaseConn(){
		Long threadId = new Long(Thread.currentThread().getId());
		Connection cn = ((ConnectionWrapper)connections.get(threadId)).getConn();
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
		Connection cn = ((ConnectionWrapper)connections.get(threadId)).getConn();
		try{
			log.debug("rollback on connection id: " + cn.hashCode() + " thread id: " + threadId);
			cn.rollback();
		}catch(Exception e){
			log.error(e.getMessage(), e);
		}
	}
	
	
	
}
