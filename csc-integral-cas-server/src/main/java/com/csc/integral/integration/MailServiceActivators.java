package com.csc.integral.integration;

import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Service;

import com.csc.integral.identity.User;
import com.csc.integral.mail.MailAgent;

/**
 *
 */
@Service("mailServiceActivators")
public class MailServiceActivators {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private MailAgent resetPasswordMailAgent;

    public void notifyPasswordReset(User user) {
    	logger.info("password reset");
    	SimpleMailMessage mailMessage = new SimpleMailMessage();
    	mailMessage.setTo(user.getEmail());
		HashMap<String, Object> data = new HashMap<String, Object>();
		data.put("user", user);
		resetPasswordMailAgent.setData(data);
		resetPasswordMailAgent.send(mailMessage);
    }

}
