package com.upmile.junit;

import java.util.ArrayList;
import java.util.List;

import org.apache.http.HttpHost;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

public class TestUser implements Runnable {
	private DefaultHttpClient httpclient;
	private HttpHost target;
	private String loginOper;
	private String submitOrderOper;
	
	
	public TestUser(String login, String submitOrder){
		 try {
			 loginOper = login;
			 submitOrderOper = submitOrder;
			 httpclient = new DefaultHttpClient();
			 target = new HttpHost("localhost", 8080, "http");
			 HttpPost post = new HttpPost("/content");
			 List<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>(2);
		     nameValuePairs.add(new BasicNameValuePair("payload", loginOper));
		     nameValuePairs.add(new BasicNameValuePair("datatype", "json"));
			 post.setEntity(new UrlEncodedFormEntity(nameValuePairs));
			 HttpResponse resp = httpclient.execute(target, post);
			 EntityUtils.consume(resp.getEntity());
		 }catch(Exception e){
			 System.out.println(e.getMessage());
		 }

	}
	
	
	private void submitOrder(){
		try{
			HttpPost post = new HttpPost("/content");
			List<NameValuePair> submitOrder = new ArrayList<NameValuePair>(2);
			submitOrder.add(new BasicNameValuePair("payload", submitOrderOper));
			submitOrder.add(new BasicNameValuePair("datatype", "json"));
			post.setEntity(new UrlEncodedFormEntity(submitOrder));
			HttpResponse resp = httpclient.execute(target, post);
			EntityUtils.consume(resp.getEntity());
	 	}catch(Exception e){
	 		System.out.println(e.getMessage());
	 	}
		
	}
	
	@Override
	public void run() {
		submitOrder();
	}

}
