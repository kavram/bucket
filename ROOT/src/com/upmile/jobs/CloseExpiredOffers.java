package com.upmile.jobs;

import java.util.Collection;
import org.apache.log4j.Logger;
import com.upmile.data.IObject;
import com.upmile.data.IObjectWrapper;
import com.upmile.operation.OperationHelper;
import com.upmile.persistence.ConnectionFactory;
import com.upmile.util.VelocityHelper;

public class CloseExpiredOffers {
	static Logger log = Logger.getLogger(CloseExpiredOffers.class);

	public void close()  {
		try {
			ConnectionFactory cf = ConnectionFactory.getInstance();
			cf.createConnection();
			closeOffers();
			cf.commitAndReleaseConn();
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
	}

	private void closeOffers(){
    	try {
    		log.debug("CloseActiveOffers job");
    		OperationHelper oh = new OperationHelper(39, null, null);
    		IObjectWrapper odw = oh.execOperation();
    		if(odw.getObjects().size() > 0){
    			for(IObject ob : odw.getObjects()){
    				closeOffer(ob);
    			}
    		}
    			
    	}catch(Exception ex){
    		log.error("Exception: " + ex.getMessage(), ex);
    	}
	}
	
	private void closeOffer(IObject offer) throws Exception{
		Collection<IObject> orders = getPendingOrders(offer);
		for(IObject order : orders){
			IObject customer = getCustomer(order.getINode("user_id").getValue().toString());
			setOrderToClosed(order);
			sendEmailToCustomer(offer, order, customer);
		}
		setOfferToClose(offer);
	}

	private void sendEmailToCustomer(IObject offer, IObject order,	IObject customer) throws Exception {
		VelocityHelper vh = new VelocityHelper("emailCustomerOfferClosed.vm"); 
		vh.addOfferOrderVariables(offer, order);
		vh.addVariable("customer", customer);
		OperationHelper.savePendingEmail(customer.getNodeValueAsStr("email"), null, vh);
	}

	private void setOfferToClose(IObject offer) throws Exception{
		OperationHelper oh = new OperationHelper(46, null, null);
		oh.addParameter("id", offer.getINode("id").getValue().toString());
		oh.execOperation();
	}
	
	
	private void setOrderToClosed(IObject order) throws Exception {
		OperationHelper oh = new OperationHelper(41, null, null);
		oh.addParameter("id", order.getINode("id").getValue().toString());
		//oh.addField("closed_discount", new Double(offerDisc));
		oh.execOperation();
	}
	
	private IObject getCustomer(String id) throws Exception{
		OperationHelper oh = new OperationHelper(11, null, null);
		oh.addParameter("id", id);
		return (IObject) oh.execOperation().getObjects().toArray()[0];
	}
	
	private Collection<IObject> getPendingOrders(IObject offer) throws Exception {
		OperationHelper oh = new OperationHelper(40, null, null);
		oh.addParameter("offer_id", offer.getINode("id").getValue().toString());
    	return oh.execOperation().getObjects();
		
	}
	
}
