package org.jasig.cas.web.flow;

import java.util.Iterator;
import java.util.Map;

import org.jasig.cas.authentication.UsernamePasswordCredential;
import org.jasig.cas.web.support.WebUtils;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.webflow.action.AbstractAction;
import org.springframework.webflow.execution.Event;
import org.springframework.webflow.execution.RequestContext;

import com.csc.integral.identity.UserPasswordAttributes;
import com.csc.integral.identity.services.IdentityService;

public final class PasswordWarningCheckAction extends AbstractAction implements InitializingBean {

    private final IdentityService identityService;

    /**
     * If password's remaining time before expiration is less than or equal with
     * this number (of days), password expiration warning should be set
     */
    private final int pwdWarningDays;

    public PasswordWarningCheckAction(IdentityService identityService, int pwdWarningDays) {
        this.identityService = identityService;
        this.pwdWarningDays = pwdWarningDays;
    }

    protected Event doExecute(final RequestContext context) throws Exception {
        this.logger.debug("checking account status--");

        // Sanity check for user validity and service ticket
        //UsernamePasswordCredential credentials = (UsernamePasswordCredential) context
        //        .getFlowScope().get("credentials");
        //String userId = credentials != null ? credentials.getUsername() : null;
        
        String userId = WebUtils.getHttpServletRequest(context).getParameter("username");
        this.logger.debug("userId='" + userId + "'");
        
        
        String ticket = WebUtils.getTicketGrantingTicketId(context);
        
        if ((userId == null) && (ticket == null)) {
            this.logger.warn("No user principal or service ticket available!");
            return error();
        }

        if ((userId == null) && (ticket != null)) {
            this.logger.info("Not a login attempt, skipping PasswordWarnCheck");
            return success();
        }
       
        // Check for password expiration
        UserPasswordAttributes pwdAttrs = identityService.getPasswordAttributes(userId);
        int pwdRemainingDays = pwdAttrs.getDaysBeforeExpiration();
        this.logger.debug("userId='" + userId + "' - pwdRemainingDays: " + pwdRemainingDays + " - pwdWarningDays: " + pwdWarningDays);
        if (pwdRemainingDays <= pwdWarningDays) {
            this.logger.debug("password for '" + userId + "' is expiring in " + pwdRemainingDays
                    + " days. Sending the warning page.");
            context.getFlowScope().put("userName", userId);
            context.getFlowScope().put("changePassUrl", context.getExternalContext().getContextPath() + "/pms/changePassword?userName="+userId);            
            context.getFlowScope().put("expireDays", pwdRemainingDays);
            context.getFlowScope().put(
                    "redirectUrl", context.getRequestParameters().get("service"));

            return Warning();
        }

        return success();
    }

    private Event Warning() {
        return result("showWarning");
    }

}