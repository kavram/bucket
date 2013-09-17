package com.upmile.meta;

import java.util.ArrayList;
import java.util.List;


public class OperationMeta {

	public static final int REGISTER_USER = 0;
	public final static int SIGNIN = 2;
	public final static int POST_OP_UPDATE_BIZ_OWNER = 3;
	public final static int POST_OP_SEND_EMAIL_AUTHORIZATION = 4;
	public final static int PRE_OP_CHECK_IF_USER_EXISTS = 5;
	public final static int PRE_OP_CHECK_IF_PASSWORD_MATCH = 6;
	public final static int POST_OP_SEND_RESET_PASSWORD_EMAL = 7;
	public final static int PRE_OP_USER_UPDATE_CHECK = 8;
	public final static int PREOP_CHECK_IF_BIZ_LOCATION_CAN_BE_UPDATED = 9;
	public final static int PREOP_CHECK_IF_USER_CAN_SUBMIT_ORDER = 10;
	public final static int POST_OP_SET_USER_TO_SESSION_AFTER_AUTHORIZATION_CONFIRM = 11;
	public final static int POST_OP_REFRESH_USER_IN_SESSION = 12;
	public final static int POST_OP_SEND_OFFER_DISCOUNT_UPDATE_EMAIL = 13;
	public final static int POST_OP_RENDER_OFFER_HTML = 14;
	public final static int POST_OP_RENDER_MY_ORDERS_HTML = 15;
	public final static int POST_OP_RENDER_MY_OFFERS_HTML = 16;
	public final static int POST_OP_NEW_OFFER_ITEMS_UPDATE = 17;
	public final static int PRE_OP_PROCESS_UPDATED_OFFER_ITEMS = 18;
	public final static int POST_OP_UPDATED_OFFER_ITEMS_UPDATE = 19;
	public final static int PRE_OP_SET_USER_DETAILS = 20;
	public final static int PRE_OP_SEND_OFFER_URL_TO_FRIEND = 21;
	public final static int POST_OP_SEND_NEW_ORDER_EMAIL = 22;
	public final static int PRE_OP_SEND_CANCEL_OFFER_EMAIL = 23;
	public final static int PRE_OP_SEND_CUSTOMER_CANCELED_ORDER_EMAIL = 24;
	public final static int PRE_OP_SEND_BIZ_CANCELED_ORDER_EMAIL = 25;
	public final static int POST_OP_CUSTOMER_UPDATED_ORDER_EMAIL = 26;
	public final static int PRE_OP_USER_CAN_INSERT_BIZ = 27;
	public final static int PRE_OP_VALIDATE_USER = 28;
	public final static int PRE_OP_USER_CAN_INSERT_NEW_DEAL = 29;
	
	
	public final static int INSERT = 0;
	public final static int UPDATE = 1;
	public final static int DELETE = 2;
	public final static int SP = 3;
	public final static int GET = 4;
	
	
	private int id;
	private int type;
	private ObjectMeta obj;
	private SpMeta sp;
	private List<OperationParamMeta> fields;
	private List<OperationParamMeta> params;
	private List<OperationParamMeta> spParams;
	private List<Integer> preOps;
	private List<Integer> postOps;

	public OperationMeta(){
		fields = new ArrayList<OperationParamMeta>();
		params = new ArrayList<OperationParamMeta>();
		spParams = new ArrayList<OperationParamMeta>();
		preOps = new ArrayList<Integer>();
		postOps = new ArrayList<Integer>();
	}
	
	public void setId(int id) {
		this.id = id;
	}

	public int getId() {
		return id;
	}

	public void setType(int type) {
		this.type = type;
	}

	public int getType() {
		return type;
	}

	public void setObjMeta(ObjectMeta obj) {
		this.obj = obj;
	}

	public ObjectMeta getObj() {
		return obj;
	}

	public void setSp(SpMeta sp) {
		this.sp = sp;
	}

	public SpMeta getSp() {
		return sp;
	}

	public void setFields(List<OperationParamMeta> fields) {
		this.fields = fields;
	}

	public List<OperationParamMeta> getFields() {
		return fields;
	}

	public void setParams(List<OperationParamMeta> params) {
		this.params = params;
	}

	public List<OperationParamMeta> getParams() {
		return params;
	}

	public void setSpParams(List<OperationParamMeta> spParams) {
		this.spParams = spParams;
	}

	public List<OperationParamMeta> getSpParams() {
		return spParams;
	}

	public void setPreOps(List<Integer> preOps) {
		this.preOps = preOps;
	}

	public List<Integer> getPreOps() {
		return preOps;
	}

	public void setPostOps(List<Integer> postOps) {
		this.postOps = postOps;
	}

	public List<Integer> getPostOps() {
		return postOps;
	}
}
