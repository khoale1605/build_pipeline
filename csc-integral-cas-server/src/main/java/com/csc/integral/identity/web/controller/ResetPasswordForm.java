package com.csc.integral.identity.web.controller;

import java.io.Serializable;

import org.hibernate.validator.constraints.NotEmpty;

/**
 * User ResetPasswordForm.
 */
public class ResetPasswordForm implements Serializable {

    private static final long serialVersionUID = 1L;

    @NotEmpty
    private String userName;
    @NotEmpty
    private String systemUsername;
    @NotEmpty
    private String systemPassword;

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

	public void setSystemUsername(String systemUsername) {
		this.systemUsername = systemUsername;
	}

	public String getSystemUsername() {
		return systemUsername;
	}

	public void setSystemPassword(String systemPassword) {
		this.systemPassword = systemPassword;
	}

	public String getSystemPassword() {
		return systemPassword;
	}
}
