package com.upmile.data;

import java.util.HashMap;
import java.util.Map;

public class PaddedPipeSeparatedStr {

	private static String[] pads = {"000000", "00000", "0000", "000", "00", "0"};
	
	private String rawValue;
	private Map<Long, Integer> parsedValue;
	
	public PaddedPipeSeparatedStr(String raw){
		this.rawValue = raw;
		parsedValue = new HashMap<Long, Integer>();
		if(raw != null && raw.length() > 0){
			String[] items = raw.split("\\^");
			for(int i = 0; i < items.length; i++){
				String[] pair = items[i].split("\\|");
				parsedValue.put(new Long(pair[0].replaceAll("^[0]+", "")), new Integer(pair[1].replaceAll("^[0]+", "")));
			}
		}
	}

	public PaddedPipeSeparatedStr(){
		parsedValue = new HashMap<Long, Integer>();
	}
	
	public Map<Long, Integer> getParsedValues(){
		return parsedValue;
	}
	
	public Integer getParsedValue(Long id){
		if(parsedValue.containsKey(id))
			return parsedValue.get(id);
		else
			return new Integer(0);
	}
	
	public String getRawValue(){
		return rawValue;
	}
	
	public String toString(){
		return rawValue;
	}
	
	public void addValue(Long key, Integer val){
		parsedValue.put(key, val);
	}
	
	public String generateRawValue(){
		StringBuffer ret = new StringBuffer();
		for(Map.Entry<Long, Integer> e : parsedValue.entrySet()){
			if(ret.length() > 0)
				ret.append("^");
			ret.append(pads[e.getKey().toString().length() - 1] + e.getKey().toString() + "|" +
					pads[e.getValue().toString().length() - 1] + e.getValue().toString());
		}
		return ret.toString();
	}
}
