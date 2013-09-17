package com.upmile.meta;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;


import com.upmile.persistence.PersistenceUtil;


public class MetaDataManager {
	static Logger log = Logger.getLogger(MetaDataManager.class);
	private static Map<String, ObjectMeta> objectsByName;
	private static Map<Integer, ObjectMeta> objectsById;
	private static Map<Integer, DataTypeMeta> dataTypes;
	private static Map<String, SpMeta> spByName;
	private static Map<Integer, SpMeta> spById;	
	private static UrlElementMeta rootUrlElement;
	private static Map<Integer, OperationMeta> opers;
	

	public static JSONObject getObjectMeta(String objName, JSONArray nodes, int ownerId) throws Exception{
		return  getObjectMeta(objName).getNodesMeta(nodes, ownerId);
	}

	public JSONObject getObjectMeta(String objName, JSONArray nodes) throws Exception{
		return  getObjectMeta(objName).getNodesMeta(nodes);
	}
	
	public JSONObject getNodeMeta(String objName, String nodeName) throws Exception{
		JSONObject jo = new JSONObject(); 
		jo.accumulate("on", objName);
		if(getObjectMeta(objName) != null){
			if(getObjectMeta(objName).getNodeMeta(nodeName) != null){
				NodeMeta nm = getObjectMeta(objName).getNodeMeta(nodeName);
				getObjectMeta(objName).getNodeMeta(nm);
			}
		}
		return jo;
	}
	
	public static UrlElementMeta getRootUrlElement(){
		return rootUrlElement;
	}
	
	public static ObjectMeta getObjectMeta(Integer id){
		if(objectsById.containsKey(id))
			return objectsById.get(id);
		else
			return null;
	}

	public SpMeta getSpMeta(String sp){
		if(spByName.containsKey(sp))
			return spByName.get(sp);
		else
			return null;
	}
	
	
	public static ObjectMeta getObjectMeta(String name) throws Exception{
		if(objectsByName.containsKey(name))
			return objectsByName.get(name);
		else
			return null;
	}

	public static OperationMeta getOperation(Integer id){
		if(opers.containsKey(id))
			return opers.get(id);
		else
			return null;
	}
	
	public MetaDataManager(){}

	public void init() {
		objectsByName = new HashMap<String, ObjectMeta>();
		objectsById = new HashMap<Integer, ObjectMeta>();
		dataTypes = new HashMap<Integer, DataTypeMeta>();
		spByName = new HashMap<String, SpMeta>();
		spById = new HashMap<Integer, SpMeta>();
		opers = new HashMap<Integer, OperationMeta>();
		try {
			LoadTypesMetaData loadTypes = new LoadTypesMetaData();
			loadTypes.load();
			LoadObjectsMetaData loadObjects = new LoadObjectsMetaData();
			loadObjects.load();
			LoadSpMetaData loadSp = new LoadSpMetaData();
			loadSp.load();
			LoadUrlElementMetaData loadUrlElements = new LoadUrlElementMetaData();
			loadUrlElements.load(null);
			LoadOperationsMetaData loadOper = new LoadOperationsMetaData();
			loadOper.load();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}		
	

	class LoadSpMetaData extends PersistenceUtil{
		
		protected LoadSpMetaData() throws SQLException {
			super();
		}

		public void load() throws Exception{
			prepareStoredProcCall("{call GET_METADATA(?,?)}");
			callStmt.setString(1, "stored_procedure");
			callStmt.setInt(2, 0);
			executeStoredProc();
			postExecute();
			cleanup();
		}
		
		protected void postExecute() throws Exception {
			if(rs != null){
				while(rs.next()){
					SpMeta sm = new SpMeta();
					sm.setId(rs.getInt("id"));
					sm.setSpName(rs.getString("sp_name"));
					sm.setResultObjectId(rs.getInt("result_object_id"));
					LoadSpParameterMetaData lspParam = new LoadSpParameterMetaData();
					lspParam.loadSpParams(sm);
					spByName.put(sm.getSpName(), sm);
					spById.put(sm.getId(), sm);
				}
			}
		}

	}
	
	
	
	class LoadSpParameterMetaData extends PersistenceUtil{
		
		protected LoadSpParameterMetaData() throws SQLException {
			super();
		}

		public void loadSpParams(SpMeta sm) throws Exception{
			prepareStoredProcCall("{call GET_METADATA(?,?)}");
			callStmt.setString(1, "sp_parameters");
			callStmt.setInt(2, sm.getId());
			executeStoredProc();
			postExecute(sm);
			cleanup();
		}
		
		protected void postExecute(SpMeta sm) throws Exception {
			Map<String, SpParameterMeta> spParams = new HashMap<String, SpParameterMeta>();
			Map<Integer, SpParameterMeta> spParamsById  = new HashMap<Integer, SpParameterMeta>();			
			if(rs != null){
				while(rs.next()){
					SpParameterMeta param = new SpParameterMeta();
					param.setId(rs.getInt("id"));
					param.setParameterSqlType(rs.getInt("parameter_sql_type"));
					param.setParameterName(rs.getString("parameter_name"));
					param.setParameterType(rs.getString("parameter_type"));
					param.setFormatString(rs.getString("format_string"));
					spParams.put(param.getParameterName(), param);
					spParamsById.put(param.getId(), param);
				}
			}
			sm.setSpParameters(spParams);
			sm.setSpParamsById(spParamsById);
		}
	}
	
	

	class LoadRefObjNodesMetaData extends PersistenceUtil{
		
		protected LoadRefObjNodesMetaData() throws SQLException {
			super();
		}

		private Collection<RefObjNodeMeta> refObjNodes;
		
		public Collection<RefObjNodeMeta> loadRefObjNodes(int nodeId) throws Exception{
			refObjNodes = new ArrayList<RefObjNodeMeta>();
			prepareStoredProcCall("{call GET_METADATA(?,?)}");
			callStmt.setString(1, "ref_obj_nodes");
			callStmt.setInt(2, nodeId);
			executeStoredProc();
			postExecute();
			cleanup();
			return refObjNodes;
		}
		
		protected void postExecute() throws Exception {
			if(rs != null){
				while(rs.next()){
					RefObjNodeMeta om = new RefObjNodeMeta();
					om.setId(rs.getInt("id"));
					om.setNodeName(rs.getString("node_name"));
					om.setPermission(rs.getString("permission"));
					refObjNodes.add(om);
				}
			}
		}

	}

	
	
	class LoadTypesMetaData extends PersistenceUtil{
		
		public LoadTypesMetaData() throws Exception{
			super();
		}
		
		public void load() throws Exception{
			prepareStoredProcCall("{call GET_METADATA(?,?)}");
			callStmt.setString(1, "data_type");
			callStmt.setInt(2, 0);
			executeStoredProc();
			postExecute();
			cleanup();
		}
		
		protected void postExecute() throws Exception {
			if(rs != null){
				while(rs.next()){
					DataTypeMeta tm = new DataTypeMeta();
					tm.setId(rs.getInt("id"));
					tm.setName(rs.getString("name"));
					tm.setName(rs.getString("description"));					
					tm.setDbType(rs.getString("db_type"));
					tm.setJavaType(rs.getString("java_type"));
					tm.setFormatString(rs.getString("format_string"));
					dataTypes.put(tm.getId(), tm);
				}
			}
		}

	}
	
	class LoadNodeValuesMetaData extends PersistenceUtil{

		protected LoadNodeValuesMetaData() throws SQLException {
			super();
		}

		Collection<NodeValueMeta> coll = new ArrayList<NodeValueMeta>();

		public Collection<NodeValueMeta> getNodeValues(int nodeId) throws Exception{
			prepareStoredProcCall("{call GET_METADATA(?,?)}");
			callStmt.setString(1, "node_value");
			callStmt.setInt(2, nodeId);
			executeStoredProc();
			postExecute();
			cleanup();
			return coll;
		}

		protected void postExecute() throws Exception {
			if(rs != null){
				while(rs.next()){
					NodeValueMeta nv = new NodeValueMeta();
					nv.setId(rs.getInt("id"));
					nv.setName(rs.getString("name"));
					nv.setValue(rs.getString("value"));
					nv.setLabel(rs.getString("label"));
					coll.add(nv);
				}
			}
		}

	}
	
	
	class LoadObjectsMetaData extends PersistenceUtil{
		
		protected LoadObjectsMetaData() throws SQLException {
			super();
		}

		public void load() throws Exception{
			prepareStoredProcCall("{call GET_METADATA(?,?)}");
			callStmt.setString(1, "object");
			callStmt.setInt(2, 0);
			executeStoredProc();
			postExecute();
			cleanup();
		}
		
		protected void postExecute() throws Exception {
			if(rs != null){
				while(rs.next()){
					ObjectMeta om = new ObjectMeta();
					om.setId(rs.getInt("id"));
					om.setName(rs.getString("name"));
					om.setCustomNodesAllowed(rs.getInt("custom_nodes"));
					om.setDataTable(rs.getString("data_table_name"));
					objectsByName.put(om.getName(), om);
					objectsById.put(new Integer(om.getId()), om);
					LoadNodesMetaData loadNodes = new LoadNodesMetaData();
					loadNodes.load(om);
					LoadCustomNodesMetaData loadCustomNodes = new LoadCustomNodesMetaData();
					loadCustomNodes.load(om);
				}
			}
		}
		
	}

	class LoadCustomNodesMetaData extends PersistenceUtil{
		
		Map<Integer, UserCustomNodeMeta> nodes = new HashMap<Integer, UserCustomNodeMeta>();
		ObjectMeta pObj = null;
		
		protected LoadCustomNodesMetaData() throws SQLException {
			super();
		}

		public void load(ObjectMeta parentObj) throws Exception{
			pObj = parentObj;
			prepareStoredProcCall("{call GET_METADATA(?,?)}");
			callStmt.setString(1, "custom_node");
			callStmt.setInt(2, parentObj.getId());
			executeStoredProc();
			postExecute();
			cleanup();
		}
		
		protected void postExecute() throws Exception {
			if(rs != null){
				while(rs.next()){
					UserCustomNodeMeta nm = new UserCustomNodeMeta();
					Integer nodeId = rs.getInt("node_id");
					nm.setId(rs.getInt("id"));
					nm.setOwnerId(rs.getInt("owner_id"));
					nm.setNodeMeta(pObj.getNodesById().get(nodeId));
					nm.setNodeLabel(rs.getString("node_label"));
					nm.setStatus(rs.getInt("status"));
					if(pObj.getCustomNodes().containsKey(nm.getOwnerId())){
						pObj.getCustomNodes().get(nm.getOwnerId()).put(nodeId, nm);
					}else{
						Map<Integer, UserCustomNodeMeta> map = new HashMap<Integer, UserCustomNodeMeta>();
						map.put(nodeId, nm);
						pObj.getCustomNodes().put(nm.getOwnerId(), map);
					}
				}
			}
		}
		
	}
	
	class LoadNodesMetaData extends PersistenceUtil{
		
		Map<String, NodeMeta> nodes = new HashMap<String, NodeMeta>();
		ObjectMeta pObj = null;
		
		protected LoadNodesMetaData() throws SQLException {
			super();
		}

		public void load(ObjectMeta parentObj) throws Exception{
			pObj = parentObj;
			prepareStoredProcCall("{call GET_METADATA(?,?)}");
			callStmt.setString(1, "node");
			callStmt.setInt(2, parentObj.getId());
			executeStoredProc();
			postExecute();
			cleanup();
		}
		
		protected void postExecute() throws Exception {
			if(rs != null){
				while(rs.next()){
					NodeMeta nm = new NodeMeta();
					nm.setNodeId(rs.getInt("id"));
					Integer typeId = rs.getInt("type_id");
					log.debug("node id: " + nm.getNodeId());
					System.out.println("node id: " + nm.getNodeId());
					nm.setParentObject(pObj);
					nm.setNodeType(rs.getInt("node_type"));
					nm.setRequired(rs.getInt("required"));
					nm.setCardinality(rs.getInt("cardinality"));
					nm.setCustomizable(rs.getInt("customizable"));
					nm.setNodeName(rs.getString("node_name"));
					nm.setHtmlType(rs.getString("html_type"));
					nm.setHtmlLabel(rs.getString("html_label"));
					LoadNodeValuesMetaData tv = new LoadNodeValuesMetaData();
					nm.setNodeValues(tv.getNodeValues(nm.getNodeId()));
					if(typeId != null && typeId != 0){
						nm.setDbType(dataTypes.get(typeId).getDbType());
						nm.setJavaType(dataTypes.get(typeId).getJavaType());
						nm.setDtFormatString(dataTypes.get(typeId).getFormatString());
					}
					if(nm.getNodeType() == NodeMeta.NODE_TYPE_REFERENCE){
						LoadRefObjNodesMetaData lnr = new LoadRefObjNodesMetaData();
						nm.setRefObjNodesMeta(lnr.loadRefObjNodes(nm.getNodeId()));
						nm.setKeyField(rs.getString("key_field"));
						nm.setRefObjKeyField(rs.getString("ref_obj_key_field"));
						nm.setRefObjId(rs.getInt("ref_obj_id"));	
					}else if(nm.getNodeType() == NodeMeta.NODE_TYPE_FK){
						nm.setRefObjKeyField(rs.getString("ref_obj_key_field"));
						nm.setRefObjId(rs.getInt("ref_obj_id"));
					}
					pObj.getNodes().put(nm.getNodeName(), nm);
					pObj.getNodesById().put(nm.getNodeId(), nm);
					if(nm.getDbFieldName() != null)
						pObj.getNodesByDBField().put(nm.getDbFieldName(), nm);
				}
			}
		}
		
	}

	class LoadUrlElementMetaData extends PersistenceUtil{
		
		protected LoadUrlElementMetaData() throws Exception {
			super();
			prepareStoredProcCall("{call GET_METADATA(?,?)}");
		}

		public void load(UrlElementMeta parent) throws Exception{
			long elementId;
			if(parent == null)
				elementId = 0;
			else
				elementId = parent.getId();
			callStmt.setString(1, "urlelement");
			callStmt.setLong(2, elementId);
			executeStoredProc();
			postExecute(parent);
		}
		
		public void cleanup(){
			cleanup();
		}
		
		protected void postExecute(UrlElementMeta parent) throws Exception {
			if(rs != null){
				while(rs.next()){
					UrlElementMeta uem = new UrlElementMeta();
					uem.setId(rs.getInt("id"));
					uem.setElement(rs.getString("element"));
					String preOps = rs.getString("get_pre_ops");
					if(preOps != null){
						String[] split = preOps.split("\\,");
						for(int i = 0; i < split.length; i++){
							Integer op = new Integer(split[i]);
							uem.getGetPreOps().add(op);
						}
					}
					String postOps = rs.getString("post_ops");
					if(postOps != null){
						String[] split = postOps.split("\\,");
						for(int i = 0; i < split.length; i++){
							Integer op = new Integer(split[i]);
							uem.getPostOps().add(op);
						}
					}
					Long templateId =  rs.getLong("template_id");
					if(templateId != null){
						LoadHtmlTemplateMetaData loadTemplate = new LoadHtmlTemplateMetaData();
						uem.setTemplate(loadTemplate.load(templateId));
					}
					if(parent != null)
						parent.getChildrenElements().put(uem.getElement(), uem);
					else
						rootUrlElement = uem;
				}
			}
			rs.close();
			if(parent == null)
				load(rootUrlElement);
			else{
				for(UrlElementMeta um : parent.getChildrenElements().values()){
					load(um);
				}
			}
		}
	}
	
	class LoadHtmlTemplateMetaData extends PersistenceUtil{
		
		private HtmlTemplateMeta htm;
		
		protected LoadHtmlTemplateMetaData() throws SQLException {
			super();
		}

		public HtmlTemplateMeta load(Long templateId) throws Exception{
			prepareStoredProcCall("{call GET_METADATA(?,?)}");
			callStmt.setString(1, "html_template");
			callStmt.setLong(2, templateId);
			executeStoredProc();
			postExecute();
			cleanup();
			return htm;
		}
		
		protected void postExecute() throws Exception {
			if(rs != null){
				while(rs.next()){
					htm = new HtmlTemplateMeta();
					htm.setId(rs.getInt("id"));
					htm.setTemplate(rs.getString("template"));
					String ops = rs.getString("ops");
					if(ops != null){
						String[] split = ops.split("\\,");
						for(int i = 0; i < split.length; i++){
							Integer op = new Integer(split[i]);
							htm.getOps().add(op);
						}
					}
				}
			}
		}
	}
	
	class LoadHtmlTemplatesMetaData extends PersistenceUtil{
		
		protected LoadHtmlTemplatesMetaData() throws SQLException {
			super();
		}

		public void load() throws Exception{
			prepareStoredProcCall("{call GET_METADATA(?,?)}");
			callStmt.setString(1, "html_templates");
			callStmt.setNull(2, 0);
			executeStoredProc();
			postExecute();
			cleanup();
		}
		
		protected void postExecute() throws Exception {
			if(rs != null){
				while(rs.next()){
					OperationMeta om = new OperationMeta();
					om.setId(rs.getInt("id"));
					om.setType(rs.getInt("type"));
					String ops = rs.getString("pre_ops");
					if(ops != null){
						String[] split = ops.split("/");
						for(int i = 0; i < split.length; i++){
							Integer op = new Integer(split[i]);
							om.getPreOps().add(op);
						}
					}
					ops = rs.getString("post_ops");
					if(ops != null){
						String[] split = ops.split("/");
						for(int i = 0; i < split.length; i++){
							Integer op = new Integer(split[i]);
							om.getPostOps().add(op);
						}
					}
					if(om.getType() == OperationMeta.SP)
						om.setSp(spById.get(rs.getInt("sp_id")));
					else
						om.setObjMeta(objectsById.get(rs.getInt("object_id")));
					LoadOperationParamsMetaData loadOperParams = new LoadOperationParamsMetaData();
					loadOperParams.load(om);
					opers.put(om.getId(), om);
				}
			}
		}
	}
	
	
	
	
	
	class LoadOperationsMetaData extends PersistenceUtil{
		
		protected LoadOperationsMetaData() throws SQLException {
			super();
		}

		public void load() throws Exception{
			prepareStoredProcCall("{call GET_METADATA(?,?)}");
			callStmt.setString(1, "operations");
			callStmt.setNull(2, 0);
			executeStoredProc();
			postExecute();
			cleanup();
		}
		
		protected void postExecute() throws Exception {
			if(rs != null){
				while(rs.next()){
					OperationMeta om = new OperationMeta();
					om.setId(rs.getInt("id"));
					om.setType(rs.getInt("type"));
					String ops = rs.getString("pre_ops");
					if(ops != null){
						String[] split = ops.split(",");
						for(int i = 0; i < split.length; i++){
							Integer op = new Integer(split[i]);
							om.getPreOps().add(op);
						}
					}
					ops = rs.getString("post_ops");
					if(ops != null){
						String[] split = ops.split(",");
						for(int i = 0; i < split.length; i++){
							Integer op = new Integer(split[i]);
							om.getPostOps().add(op);
						}
					}
					if(om.getType() == OperationMeta.SP)
						om.setSp(spById.get(rs.getInt("sp_id")));
					else
						om.setObjMeta(objectsById.get(rs.getInt("object_id")));
					LoadOperationParamsMetaData loadOperParams = new LoadOperationParamsMetaData();
					loadOperParams.load(om);
					opers.put(om.getId(), om);
				}
			}
		}
	}
	
	class LoadOperationParamsMetaData extends PersistenceUtil{
		
		protected LoadOperationParamsMetaData() throws SQLException {
			super();
		}

		public void load(OperationMeta om) throws Exception{
			prepareStoredProcCall("{call GET_METADATA(?,?)}");
			callStmt.setString(1, "operation_params");
			callStmt.setInt(2, om.getId());
			executeStoredProc();
			postExecute(om);
			cleanup();
		}
		
		protected void postExecute(OperationMeta om) throws Exception {

			if(rs != null){
				while(rs.next()){
					OperationParamMeta opm = new OperationParamMeta();
					opm.setId(rs.getInt("id"));
					opm.setParamType(rs.getInt("type"));
					opm.setValue(rs.getString("value"));
					opm.setValueType(rs.getInt("value_type"));
					opm.setOperand(rs.getString("operand"));
					opm.setRequired(rs.getInt("required"));
					if(opm.getParamType() == OperationParamMeta.SP_PARAM){
						opm.setSpParam(spById.get(om.getSp().getId()).getParamById(rs.getInt("type_id")));
						om.getSpParams().add(opm);
					}else if(opm.getParamType() == OperationParamMeta.FIELD){
						NodeMeta nm = null;
						if(om.getType() == OperationMeta.SP)
							nm = objectsById.get(om.getSp().getResultObjectId()).getNodesById().get(rs.getInt("type_id"));
						else
							nm = objectsById.get(om.getObj().getId()).getNodesById().get(rs.getInt("type_id"));
						 log.debug("type id: " + rs.getInt("type_id"));
						 opm.setNode(nm);
						 if(opm.getNode().getNodeType() == NodeMeta.NODE_TYPE_REFERENCE){
							 List<OperationParamMeta> listOpm = new ArrayList<OperationParamMeta>();
							 opm.setRefOperParamMeta(listOpm);
							 LoadRefOperationParamsMetaData loadRefOperParams = new LoadRefOperationParamsMetaData();
							 loadRefOperParams.load(opm);
						 }
						 om.getFields().add(opm);
					}else if(opm.getParamType() == OperationParamMeta.PARAM){
						 opm.setNode(objectsById.get(om.getObj().getId()).getNodesById().get(rs.getInt("type_id")));
						 om.getParams().add(opm);
					}
					if(opm.getValueType() == OperationParamMeta.VALUE_TYPE_SESSION){
						String val = opm.getValue();
						String[] split = val.split("/");
						opm.setSessionValue(split);
					}
				}
			}
		}
	}

	class LoadRefOperationParamsMetaData extends PersistenceUtil{
		
		protected LoadRefOperationParamsMetaData() throws SQLException {
			super();
		}

		public void load(OperationParamMeta opm) throws Exception{
			prepareStoredProcCall("{call GET_METADATA(?,?)}");
			callStmt.setString(1, "ref_operation_params");
			callStmt.setInt(2, opm.getId());
			executeStoredProc();
			postExecute(opm);
			cleanup();
		}
		
		protected void postExecute(OperationParamMeta om) throws Exception {

			if(rs != null){
				while(rs.next()){
					OperationParamMeta opm = new OperationParamMeta();
					opm.setId(rs.getInt("id"));
					opm.setParamType(rs.getInt("type"));
					opm.setValue(rs.getString("value"));
					opm.setValueType(rs.getInt("value_type"));
					opm.setRequired(rs.getInt("required"));
					if(opm.getValueType() == OperationParamMeta.VALUE_TYPE_SESSION){
						String val = opm.getValue();
						String[] split = val.split("/");
						opm.setSessionValue(split);
					}
					opm.setNode(objectsById.get(om.getNode().getRefObjId()).getNodesById().get(rs.getInt("type_id")));
					om.getRefOperParamMeta().add(opm);
				}
			}
		}
	}
	
}
