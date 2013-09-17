package com.upmile.persistence;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import javax.sql.DataSource;
import org.apache.log4j.Logger;

public class ConnectionFactory {
	static Logger log = Logger.getLogger(ConnectionFactory.class);

	private static Map<Long, ConnectionWrapper> connections; 
	private static Object synch;
	private static ConnectionFactory _instance;
	
	private DataSource dataSource;
	
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
		synch = new Object();
		connections = new HashMap<Long, ConnectionWrapper>();
		_instance = this;
	}	
	
	public void createConnection() throws SQLException{
		Long threadId = new Long(Thread.currentThread().getId());
		if(!connections.containsKey(threadId)){
			synchronized (synch){
				ConnectionWrapper cw = new ConnectionWrapper();
				connections.put(threadId, cw);
			}
		}
//			Connection cn = DriverManager.getConnection("jdbc:mysql://" + dbServer + "/" + dbName +
//			        "?user=" + dbUser + "&password=" + dbPass);
			Connection cn = dataSource.getConnection();
			cn.setAutoCommit(false);
			ConnectionWrapper cw = connections.get(threadId);
			cw.setConnection(cn);
		//	log.debug("created connection id: " + cn.hashCode() + 
		//			" thread id: " + threadId);
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
			log.debug("commit on connection id: " + cn.hashCode() +	" thread id: " + threadId);
			cn.commit();
			cn.close();
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
			log.debug("rollback on connection id: " + cn.hashCode() + 
					" thread id: " + threadId);
			cn.rollback();
			cn.close();
		}catch(Exception e){
			log.error(e.getMessage(), e);
		}
	}

	public void rollback(){
		Long threadId = new Long(Thread.currentThread().getId());
		Connection cn = ((ConnectionWrapper)connections.get(threadId)).getConn();
		try{
			log.debug("rollback on connection id: " + cn.hashCode() + 
					" thread id: " + threadId);
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


	class ConnectionWrapper{
		private Connection conn = null;
		
		ConnectionWrapper(){
			
		}
	
		public void setConnection(Connection conn){
			this.conn = conn;
		}
		
		public Connection getConn(){
			return conn;
		}
	}
	
	
	
}
