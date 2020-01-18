package com.csc.integral.identity.web.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.ldap.core.support.LdapContextSource;
import org.springframework.security.authentication.encoding.LdapShaPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.csc.integral.cas.security.SystemUsers;
import com.csc.integral.identity.User;
import com.csc.integral.identity.dao.IdentityDao;
import com.csc.integral.identity.services.IdentityService;
import com.csc.integral.integration.Gateways;

/**
 * Handle RenderMapping and ActionMapping for ResetPasswordController.
 */
@Controller("resetPasswordController")
@RequestMapping("/pms/resetPassword")
public class ResetPasswordController {

    private static final Logger LOGGER = LoggerFactory.getLogger(ResetPasswordController.class);

    @Autowired
    private MessageSource messageSource;

    @Autowired
    private IdentityService identityManager;

    @Autowired
    private IdentityDao identityDao;

    @Autowired
    private Gateways gateways;

    @Autowired
    private SystemUsers systemUsers;

    @RequestMapping(method = RequestMethod.GET)
    public ModelAndView view(
            @ModelAttribute("resetPasswordForm") ResetPasswordForm resetPasswordForm,
            Model model) throws Exception {
        return new ModelAndView("resetPassword");
    }

    @RequestMapping(method = RequestMethod.POST, params = "action=resetPassword")
    public ModelAndView resetPassword(
    		HttpServletRequest request, HttpServletResponse response,
            @ModelAttribute("resetPasswordForm") @Valid ResetPasswordForm resetPassword,
            BindingResult bindingResult, Model model) throws Exception {
        if (!bindingResult.hasErrors()) {
        	boolean systemUserFlag = true;
        	try {
        		User systemUser = identityDao.read(resetPassword.getSystemUsername());
            	systemUserFlag = false;

            	List<String> systemUserList = new ArrayList<String>();
            	systemUserList = java.util.Arrays.asList(systemUsers.getSystemUserList().split(","));
                if (!new LdapShaPasswordEncoder().isPasswordValid(systemUser.getPassword(), resetPassword.getSystemPassword(), null)
                		|| !systemUserList.contains(resetPassword.getSystemUsername())) {
                    model.addAttribute("msgError", messageSource.getMessage(
                    		"screen.error.noPermissionException", null , request.getLocale()));
                }
                else {
	                String username = resetPassword.getUserName();
	                String generatedPassword = identityManager.resetPassword(username);
	                com.csc.integral.identity.User user = identityDao.read(username);
	                user.setPassword(generatedPassword);
	                gateways.notifyPasswordReset(user);
	                model.addAttribute("msgStatus", "screen.resetPassword.resetSuccess");
                }
            } catch (org.springframework.ldap.NameNotFoundException ex) {
            	if (systemUserFlag){
            		model.addAttribute("msgError", messageSource.getMessage(
                			"screen.error.systemUserNotExist", null , request.getLocale()));
            	} else {
	            	model.addAttribute("msgError", messageSource.getMessage(
	            			"screen.error.userNotExist", null , request.getLocale()));
            	}
            } catch (org.springframework.ldap.NoPermissionException ex) { //[LDAP: error code 50 - Insufficient Access Rights]
            	model.addAttribute("msgError", messageSource.getMessage(
            			"screen.error.noPermissionException", null , request.getLocale()));
            } catch (org.springframework.dao.EmptyResultDataAccessException ex) {
            	if (systemUserFlag){
            		model.addAttribute("msgError", messageSource.getMessage(
                			"screen.error.systemUserNotExist", null , request.getLocale()));
            	} else {
	            	model.addAttribute("msgError", messageSource.getMessage(
	            			"screen.error.userNotExist", null , request.getLocale()));
            	}
            } catch (org.springframework.dao.IncorrectResultSizeDataAccessException ex) {
            	model.addAttribute("msgError", messageSource.getMessage(
            			"screen.error.userAmbiguous", null , request.getLocale()));
            } catch (Exception ex) { //TODO: handle another error here
            	model.addAttribute("msgError", ex.getMessage());
            }
        } else {
            LOGGER.error("ERROR: " + bindingResult.toString());
        }
        return new ModelAndView("resetPassword");
    }
}
