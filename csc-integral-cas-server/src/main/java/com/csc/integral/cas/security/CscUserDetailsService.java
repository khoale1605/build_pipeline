package com.csc.integral.cas.security;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.dao.DataAccessException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.csc.integral.identity.User;
import com.csc.integral.identity.dao.IdentityDao;

/**
 * Provides user details on a LDAP back-end
 * 
 * <p>
 * This is just a preliminary implementation in which only "root" user has
 * administrators role, the others all have "users" role.
 * </p>
 */
public class CscUserDetailsService implements UserDetailsService {

    static final String ROLE_ADMIN = "ROLE_ADMIN";
    static final String ROLE_USER = "ROLE_USER";

    private static final String USER_NOT_FOUND = "User \"%s\" not found";

    private final IdentityDao identityDao;

    public CscUserDetailsService(IdentityDao identityDao) {
        this.identityDao = identityDao;
    }

    public UserDetails loadUserByUsername(final String username) throws UsernameNotFoundException,
            DataAccessException {
        try {
            User user = identityDao.read(username);

            if (user == null) {
                throw new UsernameNotFoundException(String.format(USER_NOT_FOUND, username));
            }

            return new AbstractUserDetails(user.getUserName(), user.getPassword()) {

                private static final long serialVersionUID = 1L;

                public Collection<GrantedAuthority> getAuthorities() {
                    Collection<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();

                    final String authority;
                    if ("root".equals(username)) {
                        authority = ROLE_ADMIN;
                    } else {
                        authority = ROLE_USER;
                    }

                    authorities.add(new GrantedAuthority() {

                        private static final long serialVersionUID = 1L;

                        public String getAuthority() {
                            return authority;
                        }
                    });

                    return authorities;
                }

            };
        } catch (RuntimeException e) {
            throw new UsernameNotFoundException(String.format(USER_NOT_FOUND, username));
        }
    }

}
