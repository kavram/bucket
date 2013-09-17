package com.upmile.util;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.upmile.data.IObject;
import com.upmile.web.Constants;

public class CookieUtils {
	static Logger log = Logger.getLogger(CookieUtils.class);
	static private int COOKIE_DURATION = 60 * 60 * 24 * 365 * 10; 

	
	public static void createCookie(IObject user, HttpServletResponse resp) throws Exception{
		Long id = (Long)user.getINode("id").getValue();
		String uuid = (String)user.getINode("uuid").getValue();
        Cookie ck = new Cookie(Constants.COOKIE_ID, id.toString() + "|" + uuid);
        ck.setMaxAge(COOKIE_DURATION);
        resp.addCookie(ck);
	}
	
	public static String[] getValuesFromCookie(HttpServletRequest req){
		try {
			Cookie[] cooks = req.getCookies();
			if(cooks == null)
				return null;
			for(int i = 0; i < cooks.length; i++){
				if(cooks[i].getName().equals(Constants.COOKIE_ID)){
					String[] vals = cooks[i].getValue().split("\\|");
					return vals;
				}
			}
		}catch(Exception e){
			log.error(e.getMessage(), e);
    	}
    	return null;
	}
	
	public static void removeCookie(HttpServletResponse resp){
        Cookie ck = new Cookie(Constants.COOKIE_ID, "n/a");
        ck.setMaxAge(-1);
        resp.addCookie(ck);
	}
	
	public static void addUserToSession(IObject user, String sessionStatus, HttpServletRequest httpReq) throws Exception{
		httpReq.getSession().setAttribute(Constants.USER_SESSION_STATUS, sessionStatus);
		httpReq.getSession().setAttribute(Constants.USER, user);
	}
	
}
