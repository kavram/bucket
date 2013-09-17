package com.upmile.web;

import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.View;

public class GenericView implements View {

	private String view;
	private String contentType;
	
	public GenericView(String view, String contentType){
		this.view = view;
		this.contentType = contentType;
	}
	
	@Override
	public String getContentType() {
		return contentType;
	}

	@Override
	public void render(Map<String, ?> model, HttpServletRequest req, HttpServletResponse res) throws Exception {
        res.setContentType(contentType);
        res.setCharacterEncoding(req.getCharacterEncoding());
        res.setBufferSize(view.length());
        res.setHeader("Content-Length", String.valueOf(view.length()));
        PrintWriter writer = res.getWriter();
        writer.println(view);
        writer.flush();
	}

}
