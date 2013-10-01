package com.upmile.junit;

import com.upmile.meta.MetaDataManager;
import com.upmile.operation.OperationHelper;
import com.upmile.persistence.ConnectionFactory;
import com.upmile.util.EmailUtils; 

import junit.framework.TestCase;

public class TestDataManager extends TestCase {

	
	public void testInsertUser() throws Exception {
		//ConnectionFactory.init();
		ConnectionFactory cf = ConnectionFactory.getInstance();
		try {
			//cf.createConnection();
			OperationHelper oh = new OperationHelper(8, null, null);
			oh.addField("first_name", "john");
			oh.addField("last_name", "doe");
			oh.addField("email", "test@mil.com");
			oh.addField("password", "pass");
			oh.addField("zipcode", "94122");
			oh.execOperation();
			cf.commitAndReleaseConn();
		} catch (Exception e) {
			cf.rollbackAndReleaseConn();
			e.printStackTrace();
		}
	}
	

	public void testGetDealsByLoc() throws Exception {
		ConnectionFactory cf = ConnectionFactory.getInstance();
		MetaDataManager mdm = new MetaDataManager();
		try {
			//cf.createConnection();
			OperationHelper oh = new OperationHelper(63, null, null);
			oh.addParameter("lat", 76.345);
			oh.addParameter("lon", 23.3456);
			oh.addParameter("dist", 10);
			oh.execOperation();
			cf.commitAndReleaseConn();
		} catch (Exception e) {
			cf.rollbackAndReleaseConn();
			e.printStackTrace();
		}
	}
	
	
	public void testCloseActiveOffersJob(){
		try {
//			VelocityUtils.init();
			//ConnectionFactory.init();
			ConnectionFactory cf = ConnectionFactory.getInstance();
			//cf.createConnection();
//			CloseActiveOffers af = new CloseActiveOffers();
	//		af.execute(null);
			cf.commitAndReleaseConn();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

    public void testSendEmails(){
    	EmailUtils eu = new EmailUtils();
    	ConnectionFactory cf = ConnectionFactory.getInstance();
    	try {
            //cf.createConnection();
			eu.processPendingEmails();
			cf.commitAndReleaseConn();
		} catch (Exception e) {
			cf.rollbackAndReleaseConn();
			e.printStackTrace();
		}
    }
    
}
