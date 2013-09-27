package com.upmile.jobs;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.log4j.Logger;

import com.upmile.data.IObject;
import com.upmile.operation.OperationHelper;
import com.upmile.persistence.ConnectionFactory;

public class SendEmail  {
	static Logger log = Logger.getLogger(SendEmail.class);
	
	private String smtphost = null;

	public void send()  {
    	try {
            processPendingEmails();
            ConnectionFactory.getInstance().commitAndReleaseConn();
		} catch (Exception e) {
			ConnectionFactory.getInstance().rollbackAndReleaseConn();
			log.error("Exception: " + e.getMessage(), e);
		}
	}

	private void processPendingEmails() throws Exception{
		OperationHelper oh = new OperationHelper(43, null, null);
		for(IObject obj : oh.execOperation().getObjects()){
			sendAndUpdateStatus(obj);
		}
	}
	
	private void sendAndUpdateStatus(IObject obj){
		try {
			String from = obj.getINode("from_email").getValue().toString();
			String recip = obj.getINode("recip_to").getValue().toString();
			String subj = obj.getINode("subj").getValue().toString();
			String body = obj.getINode("body").getValue().toString();
			submit(from, recip, subj, body, null);
			updateStatus(obj);
			ConnectionFactory.getInstance().commit();
		} catch (Exception e) {
			//ConnectionFactory.getInstance().rollback();
			log.error(e.getMessage(), e);
		}
	}
	
	private void updateStatus(IObject obj) throws Exception {
		OperationHelper oh = new OperationHelper(44, null, null);
		oh.addParameter("id", obj.getNodeValueAsStr("id"));
		oh.execOperation();
	}
	
	
	private void submit(String from, String recipient, String subject, String message, String fromName) throws Exception	  {
		Properties props = new Properties();
		props.put("mail.smtp.host", smtphost); //"127.0.0.1" 192.168.0.199
		Session session = Session.getDefaultInstance(props, null);
		session.setDebug(false);
		Message msg = new MimeMessage(session);
		InternetAddress addressFrom = new InternetAddress(from);
		if(fromName != null)
			addressFrom.setPersonal(fromName);
		msg.setFrom(addressFrom);
		InternetAddress addressTo = new InternetAddress(recipient);
		msg.setRecipient(Message.RecipientType.TO, addressTo);
		msg.setSubject(subject);
		msg.setContent(message, "text/html");
		Transport.send(msg);
	}

	public String getSmtphost() {
		return smtphost;
	}

	public void setSmtphost(String smtphost) {
		this.smtphost = smtphost;
	}

}
