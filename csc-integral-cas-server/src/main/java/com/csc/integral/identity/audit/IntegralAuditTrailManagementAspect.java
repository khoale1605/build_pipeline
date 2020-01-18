package com.csc.integral.identity.audit;

import java.lang.annotation.Annotation;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;

import com.github.inspektr.audit.AuditActionContext;
import com.github.inspektr.audit.AuditTrailManagementAspect;
import com.github.inspektr.audit.AuditTrailManager;
import com.github.inspektr.audit.annotation.Audit;
import com.github.inspektr.audit.annotation.Audits;
import com.github.inspektr.audit.spi.AuditActionResolver;
import com.github.inspektr.audit.spi.AuditResourceResolver;
import com.github.inspektr.common.spi.ClientInfoResolver;
import com.github.inspektr.common.spi.DefaultClientInfoResolver;
import com.github.inspektr.common.spi.PrincipalResolver;
import com.github.inspektr.common.web.ClientInfo;

/**
 * This is a copy of the {@link AuditTrailManagementAspect} from Inspektr with
 * some more advices on Integral's {@link IdentityManager}.
 */
@Aspect
public class IntegralAuditTrailManagementAspect {

    private final PrincipalResolver auditPrincipalResolver;

    private final Map<String, AuditActionResolver> auditActionResolvers;

    private final Map<String, AuditResourceResolver> auditResourceResolvers;

    private final List<AuditTrailManager> auditTrailManagers;

    private final String applicationCode;

    private ClientInfoResolver clientInfoResolver = new DefaultClientInfoResolver();

    /**
     * Constructs an AuditTrailManagementAspect with the following parameters.
     * Also, registers some default AuditActionResolvers including the
     * {@link com.github.inspektr.audit.spi.support.DefaultAuditActionResolver},
     * the
     * {@link com.github.inspektr.audit.spi.support.BooleanAuditActionResolver}
     * and the
     * {@link com.github.inspektr.audit.spi.support.ObjectCreationAuditActionResolver}
     * .
     *
     * @param applicationCode
     *            the overall code that identifies this application.
     * @param auditablePrincipalResolver
     *            the resolver which will locate principals.
     * @param auditTrailManagers
     *            the list of managers to write the audit trail out to.
     * @param auditActionResolverMap
     *            the map of resolvers by name provided in the annotation on the
     *            method.
     * @param auditResourceResolverMap
     *            the map of resolvers by the name provided in the annotation on
     *            the method.
     */
    public IntegralAuditTrailManagementAspect(final String applicationCode,
            final PrincipalResolver auditablePrincipalResolver,
            final List<AuditTrailManager> auditTrailManagers,
            final Map<String, AuditActionResolver> auditActionResolverMap,
            final Map<String, AuditResourceResolver> auditResourceResolverMap) {
        this.auditPrincipalResolver = auditablePrincipalResolver;
        this.auditTrailManagers = auditTrailManagers;
        this.applicationCode = applicationCode;
        this.auditActionResolvers = auditActionResolverMap;
        this.auditResourceResolvers = auditResourceResolverMap;

    }

    @Around(value = "@annotation(audits)", argNames = "audits")
    public Object handleAuditTrail(final ProceedingJoinPoint joinPoint,
            final Audits audits) throws Throwable {
        Object retVal = null;
        String currentPrincipal = null;
        final String[] actions = new String[audits.value().length];
        final String[][] auditableResources = new String[audits.value().length][];
        try {
            retVal = joinPoint.proceed();
            currentPrincipal = this.auditPrincipalResolver.resolveFrom(
                    joinPoint, retVal);

            if (currentPrincipal != null) {
                for (int i = 0; i < audits.value().length; i++) {
                    final AuditActionResolver auditActionResolver = this.auditActionResolvers
                            .get(audits.value()[i].actionResolverName());
                    final AuditResourceResolver auditResourceResolver = this.auditResourceResolvers
                            .get(audits.value()[i].resourceResolverName());
                    auditableResources[i] = auditResourceResolver.resolveFrom(
                            joinPoint, retVal);
                    actions[i] = auditActionResolver.resolveFrom(joinPoint,
                            retVal, audits.value()[i]);
                }
            }
            return retVal;
        } catch (final Exception e) {
            currentPrincipal = this.auditPrincipalResolver.resolveFrom(
                    joinPoint, e);

            if (currentPrincipal != null) {
                for (int i = 0; i < audits.value().length; i++) {
                    auditableResources[i] = this.auditResourceResolvers.get(
                            audits.value()[i].resourceResolverName())
                            .resolveFrom(joinPoint, e);
                    actions[i] = auditActionResolvers.get(
                            audits.value()[i].actionResolverName())
                            .resolveFrom(joinPoint, e, audits.value()[i]);
                }
            }
            throw e;
        } finally {
            for (int i = 0; i < audits.value().length; i++) {
                executeAuditCode(currentPrincipal, auditableResources[i],
                        joinPoint, retVal, actions[i], audits.value()[i]);
            }
        }
    }

    @Around(value = "@annotation(audit)", argNames = "audit")
    public Object handleAuditTrail(final ProceedingJoinPoint joinPoint,
            final Audit audit) throws Throwable {
        final AuditActionResolver auditActionResolver = this.auditActionResolvers
                .get(audit.actionResolverName());
        final AuditResourceResolver auditResourceResolver = this.auditResourceResolvers
                .get(audit.resourceResolverName());

        String currentPrincipal = null;
        String[] auditResource = null;
        String action = null;
        Object retVal = null;
        try {
            retVal = joinPoint.proceed();

            currentPrincipal = this.auditPrincipalResolver.resolveFrom(
                    joinPoint, retVal);
            auditResource = auditResourceResolver
                    .resolveFrom(joinPoint, retVal);
            action = auditActionResolver.resolveFrom(joinPoint, retVal, audit);

            return retVal;
        } catch (final Exception e) {
            currentPrincipal = this.auditPrincipalResolver.resolveFrom(
                    joinPoint, e);
            auditResource = auditResourceResolver.resolveFrom(joinPoint, e);
            action = auditActionResolver.resolveFrom(joinPoint, e, audit);
            throw e;
        } finally {
            executeAuditCode(currentPrincipal, auditResource, joinPoint,
                    retVal, action, audit);
        }
    }

    private void executeAuditCode(final String currentPrincipal,
            final String[] auditableResources,
            final ProceedingJoinPoint joinPoint, final Object retVal,
            final String action, final Audit audit) {
        final String myApplicationCode = (audit.applicationCode() != null && audit
                .applicationCode().length() > 0) ? audit.applicationCode()
                : this.applicationCode;
        final ClientInfo clientInfo = this.clientInfoResolver.resolveFrom(
                joinPoint, retVal);
        final Date actionDate = new Date();
        for (final String auditableResource : auditableResources) {
            final AuditActionContext auditContext = new AuditActionContext(
                    currentPrincipal, auditableResource, action,
                    myApplicationCode, actionDate, clientInfo
                            .getClientIpAddress(), clientInfo
                            .getServerIpAddress(), null);
            // Finally record the audit trail info
            for (AuditTrailManager manager : auditTrailManagers) {
                manager.record(auditContext);
            }
        }
    }

    public void setClientInfoResolver(final ClientInfoResolver factory) {
        this.clientInfoResolver = factory;
    }

    @Around("execution(* com.csc.integral.identity.services.impl.IdentityServiceLdapImpl.changePassword(..))")
    public Object handlePasswordChange(final ProceedingJoinPoint joinPoint)
            throws Throwable {

        Object[] args = joinPoint.getArgs();
        Object retVal = null;
        boolean success = false;
        try {
            retVal = joinPoint.proceed(args);
            success = true;
        } finally {
            executeAuditCode((String) args[0],
					new String[] { "password change" }, joinPoint, retVal,
					success ? "PASSWORD_CHANGE_SUCCESS"
							: "PASSWORD_CHANGE_FAILED", new Audit() {

                        public Class<? extends Annotation> annotationType() {
                            return null;
                        }

                        public String resourceResolverName() {
                            return null;
                        }

                        public String applicationCode() {
                            return null;
                        }

                        public String actionResolverName() {
                            return null;
                        }

                        public String action() {
                            return null;
                        }
                    });
        }
        return retVal;
    }

    @Around("execution(* com.csc.integral.identity.services.impl.IdentityServiceLdapImpl.resetPassword(..))")
    public Object handleResetPassword(final ProceedingJoinPoint joinPoint) throws Throwable {

        Object[] args = joinPoint.getArgs();
        Object retVal = null;
        boolean success = false;
        try {
            retVal = joinPoint.proceed(args);
            success = true;
        } finally {
            executeAuditCode((String) args[0],
                    new String[] {"password reset"}, joinPoint, retVal,
                    success ? "PASSWORD_RESET_SUCCESS"
                            : "PASSWORD_RESET_FAILED", new Audit() {

                        public Class<? extends Annotation> annotationType() {
                            return null;
                        }

                        public String resourceResolverName() {
                            return null;
                        }

                        public String applicationCode() {
                            return null;
                        }

                        public String actionResolverName() {
                            return null;
                        }

                        public String action() {
                            return null;
                        }
                    });
        }
        return retVal;
    }
}
