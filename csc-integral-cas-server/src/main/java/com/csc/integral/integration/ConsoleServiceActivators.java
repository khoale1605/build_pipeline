package com.csc.integral.integration;

import java.util.Calendar;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.csc.integral.identity.User;

/**
 *
 */
@Service("consoleServiceActivators")
public class ConsoleServiceActivators {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

    public void notifyPasswordReset(User user) {
    	logger.info("New password for user " + user.getUserName() + " : " + user.getPassword());
		String message = Calendar.getInstance().getTime().toString()
				+ "\nUser:" + user.getUserName()
				+ "\nEmail:" + user.getEmail()
				+ "\nNew password:" + user.getPassword()
				+ "\nPassword has been reset successful.";
		System.out.println(message);
    }
}
