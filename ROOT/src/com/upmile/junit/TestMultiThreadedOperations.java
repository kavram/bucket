package com.upmile.junit;

import java.util.ArrayList;
import java.util.Collection;
import java.util.concurrent.Callable;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;


import junit.framework.TestCase;

public class TestMultiThreadedOperations extends TestCase {

	private final ScheduledExecutorService sched = Executors.newScheduledThreadPool(5);
	
	public void testTwoOrderSubmits(){
		String user1Login = "[{'id':10,'parameters':{'email':{'value':'kirill_avramenko@yahoo.com'},'password':{'value':'111111'}},'fields':{}}]";
		String user1SubmitOrder = "[{'id':5,'parameters':{'oid':'72','ordr':'120|10,121|20,124|10'},'fields':{}}]";
		String user2Login = "[{'id':10,'parameters':{'email':{'value':'kavramen@hotmail.com'},'password':{'value':'kirakir'}},'fields':{}}]";
		String user2SubmitOrder = "[{'id':5,'parameters':{'oid':'72','ordr':'120|15,121|5,124|10'}}]";
		String user3Login = "[{'id':10,'parameters':{'email':{'value':'dj@test.com'},'password':{'value':'123456'}},'fields':{}}]";
		String user3SubmitOrder = "[{'id':5,'parameters':{'oid':'72','ordr':'120|5,121|5,124|10'}}]";

		
		final Runnable user1 = new TestUser(user1Login, user1SubmitOrder);
		final Runnable user2 = new TestUser(user2Login, user2SubmitOrder);
		final Runnable user3 = new TestUser(user3Login, user3SubmitOrder);
		Callable<Object> cUser1 = Executors.callable(user1);
		Callable<Object> cUser2 = Executors.callable(user2);
		Callable<Object> cUser3 = Executors.callable(user3);
		Collection<Callable<Object>> coll = new ArrayList<Callable<Object>>();
		coll.add(cUser2);
		coll.add(cUser1);
		coll.add(cUser3);
		try {
			sched.invokeAll(coll);
		} catch (InterruptedException e) {
			System.out.println(e.getMessage());
		}
	}
	
}
