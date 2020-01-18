package com.csc.integral.integration;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.integration.message.ErrorMessage;
import org.springframework.stereotype.Service;

@Service("integrationErrorHandler")
public class IntegrationErrorHandler {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	public void log(ErrorMessage errorMessage) {
		Throwable t = errorMessage.getPayload();
		logger.error(t.getMessage());
		t.printStackTrace();
	}

}
