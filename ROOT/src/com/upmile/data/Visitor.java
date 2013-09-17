package com.upmile.data;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;

import com.upmile.meta.DataTypeMeta;
import com.upmile.meta.ObjectMeta;
import com.upmile.persistence.PersistenceUtil;

public abstract class Visitor {
	static Logger log = Logger.getLogger(Visitor.class);
	protected PersistenceUtil pu;
	protected Map<Integer, SQLParam> parameters = new HashMap<Integer, SQLParam>();
	protected String where = "";
	protected ObjectMeta om;
	protected String from;
	protected int ind = 1;

	public void addWhereParam(SQLParam wp){
		parameters.put(Integer.valueOf(ind), wp);
		ind++;
	}
	
	public void addWhereClause(String clause){
		if(!where.isEmpty())
			where += " and ";
		where += clause;
	}
	
	protected void setParameter(int ind, SQLParam wp) throws Exception{
		String type = "";
		type = wp.getFieldType();
		if(!type.isEmpty()){
			if(type.equals(DataTypeMeta.JAVA_TYPE_STRING) || type.equals(DataTypeMeta.JAVA_TYPE_JSON_ARRAY) ||
					type.equals(DataTypeMeta.JAVA_TYPE_JSON_OBJ)){
				if(wp.getParamValue() != null)
					pu.setString(ind, wp.getParamValue().toString());
				else
					pu.setNullParameter(ind, 12);
			}else if(type.equals(DataTypeMeta.PADDED_PIPE_SEPARATED_STR)){
				if(wp.getParamValue() != null){
					PaddedPipeSeparatedStr val = (PaddedPipeSeparatedStr)wp.getParamValue();
					pu.setString(ind, val.getRawValue());
				}else
					pu.setNullParameter(ind, 12);
			}else if(type.equals(DataTypeMeta.JAVA_TYPE_INTEGER)){
				if(wp.getParamValue() != null)
					pu.setInteger(ind, (Integer)wp.getParamValue());
				else
					pu.setNullParameter(ind, 4);
			}else if(type.equals(DataTypeMeta.JAVA_TYPE_LONG)){
				if(wp.getParamValue() != null)
					pu.setLong(ind, (Long)wp.getParamValue());
				else
					pu.setNullParameter(ind, -5);
			}else if(type.equals(DataTypeMeta.JAVA_TYPE_DECIMAL)){
				if(wp.getParamValue() != null)
					pu.setFloat(ind, (Float)wp.getParamValue());
				else
					pu.setNullParameter(ind, -5);
			}else if(type.equals(DataTypeMeta.JAVA_TYPE_DATE)){
				if(wp.getParamValue() != null)
					pu.setDate(ind, (Date)wp.getParamValue());
				else
					pu.setNullParameter(ind, 91);
			}else if(type.equals(DataTypeMeta.JAVA_TYPE_TIME)){
				if(wp.getParamValue() != null)
					pu.setTime(ind, (Time)wp.getParamValue());
				else
					pu.setNullParameter(ind, 92);
			}else if(type.equals(DataTypeMeta.JAVA_TYPE_TEXT)){
				if(wp.getParamValue() != null)
					pu.setText(ind, wp.getParamValue().toString());
				else
					pu.setNullParameter(ind, -3);
			}else if(type.equals(DataTypeMeta.JAVA_TYPE_DATE_TIME)){
				if(wp.getParamValue() != null)
					pu.setTimestamp(ind, new Timestamp(((java.util.Date)wp.getParamValue()).getTime()));
				else
					pu.setNullParameter(ind, 93);
			}
		}
		
	}
}
