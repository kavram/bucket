package com.upmile.meta;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class UrlElementMeta {

	private int id;
	private String element;
	private HtmlTemplateMeta template;
	private Map<String, UrlElementMeta> childrenElements;
	private List<Integer> getPreOps;
	private List<Integer> postOps;
	
	public UrlElementMeta(){
		childrenElements = new HashMap<String, UrlElementMeta>();
		setGetPreOps(new ArrayList<Integer>());
		setPostOps(new ArrayList<Integer>());
	}
	
	public void setId(int id) {
		this.id = id;
	}

	public int getId() {
		return id;
	}

	public void setTemplate(HtmlTemplateMeta template) {
		this.template = template;
	}

	public HtmlTemplateMeta getTemplate() {
		return template;
	}

	public void setElement(String element) {
		this.element = element;
	}

	public String getElement() {
		return element;
	}

	public void setChildrenElements(Map<String, UrlElementMeta> childrenElements) {
		this.childrenElements = childrenElements;
	}

	public Map<String, UrlElementMeta> getChildrenElements() {
		return childrenElements;
	}

	public List<Integer> getGetPreOps() {
		return getPreOps;
	}

	public void setGetPreOps(List<Integer> getPreOps) {
		this.getPreOps = getPreOps;
	}

	public List<Integer> getPostOps() {
		return postOps;
	}

	public void setPostOps(List<Integer> postOps) {
		this.postOps = postOps;
	}

}
