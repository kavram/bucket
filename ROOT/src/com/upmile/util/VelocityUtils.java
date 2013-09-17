package com.upmile.util;

import java.util.Properties;

import org.apache.log4j.Logger;
import org.apache.velocity.app.Velocity;


public class VelocityUtils {
	static Logger log = Logger.getLogger(VelocityUtils.class);
	
	private String filePath;
	private String loader;
	private String forEachScopeControl;
	private String interpolateStringLiterals;
	private static String domain;
	private static String uploadedImagesUrl;
	private static String uploadedImagesPath;
	
	
	public void init(){
		try {
			Properties props = new Properties();
			props.put("file.resource.loader.path", filePath);
			props.put("resource.loader", loader);
			props.put("foreach.provide.scope.control", forEachScopeControl);
			props.put("runtime.interpolate.string.literals", interpolateStringLiterals);
			Velocity.init(props);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getLoader() {
		return loader;
	}

	public void setLoader(String loader) {
		this.loader = loader;
	}

	public String getForEachScopeControl() {
		return forEachScopeControl;
	}

	public void setForEachScopeControl(String forEachScopeControl) {
		this.forEachScopeControl = forEachScopeControl;
	}

	public String getInterpolateStringLiterals() {
		return interpolateStringLiterals;
	}

	public void setInterpolateStringLiterals(String interpolateStringLiterals) {
		this.interpolateStringLiterals = interpolateStringLiterals;
	}

	public void setDomain(String domain) {
		VelocityUtils.domain = domain;
	}

	public static String getDomain() {
		return VelocityUtils.domain;
	}

	public void setUploadedImagesUrl(String uploadedImagesUrl) {
		VelocityUtils.uploadedImagesUrl = uploadedImagesUrl;
	}

	public static String getUploadedImagesUrl() {
		return VelocityUtils.uploadedImagesUrl;
	}

	public void setUploadedImagesPath(String uploadedImagesPath) {
		VelocityUtils.uploadedImagesPath = uploadedImagesPath;
	}

	public static String getUploadedImagesPath() {
		return VelocityUtils.uploadedImagesPath;
	}

}
