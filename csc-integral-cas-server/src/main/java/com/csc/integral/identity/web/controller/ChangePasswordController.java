package com.csc.integral.identity.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.csc.integral.identity.services.IdentityService;
import com.csc.integral.identity.services.PasswordPolicyCheck;

/**
 * Handle RenderMapping and ActionMapping for ChangePasswordController.
 */
@Controller("changePasswordController")
@RequestMapping("/pms/changePassword")
public class ChangePasswordController {
    private static final Logger LOGGER = LoggerFactory
            .getLogger(ChangePasswordController.class);

    @Autowired
    private MessageSource messageSource;

    @Autowired
    private IdentityService identityManager;
    
    @Autowired
    private PasswordPolicyCheck passwordCheck;

    @RequestMapping(method = RequestMethod.GET)
    public ModelAndView view(
    		HttpServletRequest request, HttpServletResponse response,
    		@RequestParam(required = false) String userName,
            @ModelAttribute("changePasswordForm") ChangePasswordForm changePassword,
            Model model) throws Exception {
        return new ModelAndView("changePassword");
    }

    @RequestMapping(method = RequestMethod.POST, params = "action=changePassword")
    public ModelAndView changePassword(
    		HttpServletRequest request, HttpServletResponse response,
            @ModelAttribute("changePasswordForm") @Valid ChangePasswordForm changePassword,
            BindingResult bindingResult, Model model) throws Exception {
        if (!bindingResult.hasErrors()) {
            try {
            	if (passwordCheck.validate(changePassword.getNewPassword().toCharArray()).isEmpty()) {
	                identityManager.changePassword(changePassword.getUserName(),
	                		changePassword.getOldPassword(), changePassword.getNewPassword());
	                model.addAttribute("msgStatus", messageSource.getMessage(
	                		"screen.changePassword.updateSuccess", null , request.getLocale()));
            	} else {
            		model.addAttribute("msgError", messageSource.getMessage(
                			"screen.error.passwordPolicyCheckFailed", null , request.getLocale()));
            	}
            } catch (javax.naming.OperationNotSupportedException ex) {//[LDAP: error code 12 - critical extension is not recognized]
            	model.addAttribute("msgError", messageSource.getMessage(
            			"screen.error.ldapDoesNotSupport", null , request.getLocale()));
			} catch (javax.naming.NamingException ne) {
                model.addAttribute("msgError", messageSource.getMessage(
                		"screen.changePassword.updateFail", null , request.getLocale()));
            } catch (org.springframework.ldap.NameNotFoundException ex) {
            	model.addAttribute("msgError", messageSource.getMessage(
            			"screen.error.userNotExist", null , request.getLocale()));
            } catch (org.springframework.ldap.NoPermissionException ex) { //[LDAP: error code 50 - Insufficient Access Rights]
            	model.addAttribute("msgError", messageSource.getMessage(
            			"screen.error.noPermissionException", null , request.getLocale()));
            } catch (org.springframework.dao.EmptyResultDataAccessException ex) {
            	model.addAttribute("msgError", messageSource.getMessage(
            			"screen.error.userNotExist", null , request.getLocale()));
            } catch (org.springframework.dao.IncorrectResultSizeDataAccessException ex) {
            	model.addAttribute("msgError", messageSource.getMessage(
            			"screen.error.userAmbiguous", null , request.getLocale()));
			} catch (Exception ex) { //TODO: handle another error here
            	LOGGER.error("Change Password error!", ex);
            	model.addAttribute("msgError", ex.getMessage());
			}
        } else {
            LOGGER.error("ERROR: " + bindingResult.toString());
        }
        return new ModelAndView("changePassword");
    }
}
