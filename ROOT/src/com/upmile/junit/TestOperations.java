package com.upmile.junit;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.http.HttpEntity;
import org.apache.http.HttpHost;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.HttpParams;
import org.apache.log4j.Logger;


import junit.framework.TestCase;

public class TestOperations extends TestCase {
	static Logger log = Logger.getLogger(TestOperations.class);
	
	public void testLoginOperation(){
		 DefaultHttpClient httpclient = new DefaultHttpClient();
		 try {
			 HttpHost target = new HttpHost("localhost", 8080, "http");
			 HttpPost post = new HttpPost("/content");
			 //HttpParams login = new BasicHttpParams();
			 //HttpParams p = login.setParameter("payload", "{'id':10,'parameters':{'email':{'value':'kirill_avramenko@yahoo.com'},'password':{'value':'111111'}},'fields':{}}");
			 List<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>(2);
		     nameValuePairs.add(new BasicNameValuePair("payload", "[{'id':10,'parameters':{'email':{'value':'kirill_avramenko@yahoo.com'},'password':{'value':'111111'}},'fields':{}}]"));
		     nameValuePairs.add(new BasicNameValuePair("datatype", "json"));
			 post.setEntity(new UrlEncodedFormEntity(nameValuePairs));
			 HttpResponse resp = httpclient.execute(target, post);
			 
			 List<NameValuePair> submitOrder = new ArrayList<NameValuePair>(2);
			 submitOrder.add(new BasicNameValuePair("payload", "[{'id':4,'parameters':{},'fields':{'offer_id':'72','item_id':'120','oqty':0,'nqty':'10'}},{'id':4,'parameters':{},'fields':{'offer_id':'72','item_id':'121','oqty':0,'nqty':'20'}},{'id':5,'parameters':{'oid':'72','user_details':{'id':'77','name':'kirilla'}},'fields':{}}]"));
			 submitOrder.add(new BasicNameValuePair("datatype", "json"));
			 post.reset();
			 post.setEntity(new UrlEncodedFormEntity(submitOrder));
			 resp = httpclient.execute(target, post);
			 HttpEntity he = resp.getEntity();
		} catch (ClientProtocolException e) {
			System.out.println(e.getMessage());
		} catch (IOException e) {
			System.out.println(e.getMessage());
		}
		
	}
	

}
