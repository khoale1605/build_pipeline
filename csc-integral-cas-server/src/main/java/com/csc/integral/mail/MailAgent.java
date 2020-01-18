package com.csc.integral.mail;

import java.util.HashMap;
import java.util.Map;

import javax.mail.internet.MimeMessage;

import org.apache.commons.lang.ArrayUtils;
import org.apache.velocity.app.VelocityEngine;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.ui.velocity.VelocityEngineUtils;

/**
 * Agent to set receipients, message etc.
 */
public class MailAgent {

    private final Logger logger = LoggerFactory.getLogger(MailAgent.class);

    @Autowired
    private VelocityEngine velocityEngine;

    private JavaMailSender mailSender;

    private SimpleMailMessage templateMailMessage;

	private String templateLocation = null;

	private Map<String, Object> data = null;

	public MailAgent(JavaMailSender mailSender) {
		this.mailSender = mailSender;
	}

    public void send(final SimpleMailMessage mailMessage) {
		try {
			MimeMessagePreparator preparator = new MimeMessagePreparator() {
				public void prepare(MimeMessage mimeMessage) throws Exception {
					MimeMessageHelper message = new MimeMessageHelper(mimeMessage);
				    if (templateMailMessage == null) {
				    	templateMailMessage = new SimpleMailMessage();
				    }
					if (mailMessage.getFrom() != null) {
						message.setFrom(mailMessage.getFrom());
					} else {
						message.setFrom(templateMailMessage.getFrom());
					}
					if (mailMessage.getReplyTo() != null) {
						message.setReplyTo(mailMessage.getReplyTo());
					} else {
						message.setReplyTo(templateMailMessage.getReplyTo());
					}
					if (mailMessage.getSubject() != null) {
						message.setSubject(mailMessage.getSubject());
					} else {
						message.setSubject(templateMailMessage.getSubject());
					}
					if (mailMessage.getSentDate() != null) {
						message.setSentDate(mailMessage.getSentDate());
					} else if (templateMailMessage.getSentDate() != null){
						message.setSentDate(templateMailMessage.getSentDate());
					} else {
						message.setSentDate(java.util.Calendar.getInstance().getTime());
					}
					if (mailMessage.getText() != null) {
						message.setText(mailMessage.getText());
					}
					message.setTo((String[])ArrayUtils.addAll(mailMessage.getTo(), templateMailMessage.getTo()));
					message.setCc((String[])ArrayUtils.addAll(mailMessage.getCc(), templateMailMessage.getCc()));
					message.setBcc((String[])ArrayUtils.addAll(mailMessage.getBcc(), templateMailMessage.getBcc()));
					if (templateLocation != null) {
						if (data == null) {
							data = new HashMap<String, Object>();
						}
						String text = VelocityEngineUtils.mergeTemplateIntoString(
								velocityEngine, templateLocation, "utf-8", data);												
						message.setText(text, true);
					}
				}
			};
			mailSender.send(preparator);
		} catch (Exception ex) {
			logger.error(ex.getMessage(), ex);
		}
	}

	public SimpleMailMessage getTemplateMailMessage() {
		return templateMailMessage;
	}

	public void setTemplateMailMessage(SimpleMailMessage templateMailMessage) {
		this.templateMailMessage = templateMailMessage;
	}

    public String getTemplateLocation() {
		return templateLocation;
	}

	public void setTemplateLocation(String templateLocation) {
		this.templateLocation = templateLocation;
	}

	public Map<?, ?> getData() {
		return data;
	}

	public void setData(Map<String, Object> data) {
		this.data = data;
	}

}
