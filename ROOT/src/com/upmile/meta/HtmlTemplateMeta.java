package com.upmile.meta;

import java.util.ArrayList;
import java.util.List;

public class HtmlTemplateMeta {
	private long id;
	private String template;
	private List<Integer> ops;

	public HtmlTemplateMeta(){
		ops = new ArrayList<Integer>();
	}
	
	public void setId(long id) {
		this.id = id;
	}

	public long getId() {
		return id;
	}

	public void setTemplate(String template) {
		this.template = template;
	}

	public String getTemplate() {
		return template;
	}

	public void setOps(List<Integer> ops) {
		this.ops = ops;
	}

	public List<Integer> getOps() {
		return ops;
	}
}
