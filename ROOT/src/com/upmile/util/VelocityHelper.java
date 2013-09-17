package com.upmile.util;

import java.io.StringWriter;

import org.apache.log4j.Logger;
import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.Velocity;
import org.springframework.stereotype.Component;

import com.upmile.data.IObject;

@Component
public class VelocityHelper {
	static Logger log = Logger.getLogger(VelocityHelper.class);
	private String templateName;
	private VelocityContext ctx;
	
	public VelocityHelper(){
		ctx = new VelocityContext();
	}
	
	public VelocityHelper(String template){
		this.templateName = template;
		ctx = new VelocityContext(); 
	}
	
	public void addVariable(String name, Object var){
		ctx.put(name, var);
	}
	
	public Object getVariable(String name){
		return ctx.get(name);
	}
	
	public void addOfferOrderVariables(IObject offer, IObject order) throws Exception{
		OfferVelocityHelper ovh = new OfferVelocityHelper(order, offer);
		ctx.put("offer", ovh);
	}

	
	public String renderTemplate(){
		Template tmpl = Velocity.getTemplate(templateName); 
		ctx.put("domain", VelocityUtils.getDomain());
		ctx.put("imagesUrl",  VelocityUtils.getUploadedImagesUrl());
		ctx.put("OfferHelper", OfferVelocityHelper.class);
		StringWriter sw = new StringWriter();
		tmpl.merge(ctx, sw);
		return sw.toString();
	}

	public String getTemplateName() {
		return templateName;
	}

	public void setTemplateName(String templateName) {
		this.templateName = templateName;
	}
	
}
