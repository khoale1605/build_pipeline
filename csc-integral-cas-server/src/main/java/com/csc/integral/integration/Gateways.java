package com.csc.integral.integration;

import org.springframework.integration.annotation.Gateway;

/**
 * Integral user service.
 *
 */
public interface Gateways {

    @Gateway(requestChannel = "resetPaswordChannel")
    void notifyPasswordReset(com.csc.integral.identity.User user);

}
