package com.upmile.data;
 
import java.sql.SQLException;
import java.util.Map;

import org.apache.log4j.Logger;
import org.json.JSONObject;

import com.upmile.meta.NodeMeta;
import com.upmile.meta.ObjectMeta;
import com.upmile.meta.OperationMeta;
import com.upmile.meta.OperationParamMeta;
import com.upmile.operation.Operation;
import com.upmile.persistence.PersistenceUtil;

public class DataManager {
	static Logger log = Logger.getLogger(DataManager.class);
	
	private static DataManager instance;
	
	static{
		instance = new DataManager();
	}
	
	private DataManager(){}
	
	public static DataManager getInstance(){
		return instance;
	}

	public InsertData getInsertData() throws SQLException{
		return new InsertData();
	}

	public SelectData getSelectData() throws SQLException{
		return new SelectData();
	}

	public UpdateData getUpdateData() throws SQLException {
		return new UpdateData();
	}

	public ExecStoredProc getExecStoredProc() throws SQLException {
		return new ExecStoredProc();
	}

	
	public class ExecStoredProc extends PersistenceUtil{
		
		protected ExecStoredProc() throws SQLException {
			super();
		}

		public IObjectWrapper getOperationResults(ObjectMeta om, Map<String, NodeMeta> map) throws Exception{
			IObjectWrapper wrap = getResults(om, map);
			return wrap;
		}

		public void exec(OperationMeta om, JSONObject jobj, Operation op) throws Exception {
			String sql = prepareStoredProcSQL(om.getSp().getSpName(), om.getSp().getSpParameters().size());
			prepareStoredProcCall(sql);
			for(OperationParamMeta opm : om.getSpParams()){
				if(opm.getValueType() != OperationParamMeta.VALUE_TYPE_CLIENT)
					setStoredProcParameter(opm.getSpParam(), op.getValue(opm));
				else{
					if(jobj.has(opm.getSpParam().getParameterName()))
						setStoredProcParameter(opm.getSpParam(), jobj.getString(opm.getSpParam().getParameterName()));
					else
						setStoredProcParameter(opm.getSpParam(), null);
				}
			}
			executeStoredProc();
		}

		
	}
	
	class InsertData extends PersistenceUtil {

		protected InsertData() throws SQLException {
			super();
		}

		public void prepare(String sql) throws Exception{
			prepareInsertStatement(sql);
		}
		
		protected long executeInsertQuery() throws Exception {
			long id = -1;
			prepStmt.executeUpdate();
			rs = prepStmt.getGeneratedKeys();
			if(rs.next()){
				id = rs.getLong("GENERATED_KEY");
			}
			log.debug("generated key: " + id);
			return id;
		}
		
	}

	class UpdateData extends PersistenceUtil {

		protected UpdateData() throws SQLException {
			super();
		}

		public void prepare(String sql) throws Exception{
			prepareStatement(sql);
		}
		
		protected int executeUpdateQuery() throws SQLException {
			int res = -1;
			res = prepStmt.executeUpdate();
			log.debug("updated rows: " + res);
			return res;
		}
		
	}
	
	
	class SelectData extends PersistenceUtil {

		protected SelectData() throws SQLException {
			super();
		}

		public void prepare(String sql) throws Exception{
			prepareStatement(sql);
		}
		
		protected void executeSelectQuery() {
			try {
				rs = prepStmt.executeQuery();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		public IObjectWrapper getData(ObjectMeta resObj, Map<String, NodeMeta> resultNodes) throws Exception{
			return getResults(resObj, resultNodes);
		}
	}

}
