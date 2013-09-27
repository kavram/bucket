package com.upmile.persistence;

import java.sql.Connection;
import java.sql.SQLException;

import javax.sql.DataSource;

public class ConnectionWrapper {
	private Connection cn;

	private DataSource dataSource;

	
	public ConnectionWrapper() throws SQLException {
		Connection cn = dataSource.getConnection();
		cn.setAutoCommit(false);
	}

	public Connection getConn() {
		return cn;
	}

	public DataSource getDataSource() {
		return dataSource;
	}

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

}