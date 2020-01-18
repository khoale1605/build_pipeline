package com.csc.integral.identity.web.controller;

import java.io.Serializable;

import javax.validation.constraints.AssertTrue;

import org.apache.commons.lang.StringUtils;
import org.hibernate.validator.constraints.NotEmpty;

/**
 * User ChangePasswordForm.
 */
public class ChangePasswordForm implements Serializable {

    private static final long serialVersionUID = 1L;

    @NotEmpty
    private String userName;
    @NotEmpty
    private String oldPassword;
    @NotEmpty
    private String newPassword;
    @NotEmpty
    private String confirmPassword;

    public String getUserName() {
        return userName;
    }
    public void setUserName(String userName) {
        this.userName = userName;
    }
    public String getOldPassword() {
        return oldPassword;
    }
    public void setOldPassword(String oldPassword) {
        this.oldPassword = oldPassword;
    }
    public String getNewPassword() {
        return newPassword;
    }
    public void setNewPassword(String newPassword) {
        this.newPassword = newPassword;
    }
    public String getConfirmPassword() {
        return confirmPassword;
    }
    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }
    public static long getSerialversionuid() {
        return serialVersionUID;
    }

    @AssertTrue
    public boolean isPasswordMatched() {
        return StringUtils.equals(newPassword, confirmPassword);
    }
}
