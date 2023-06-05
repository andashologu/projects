package com.kapelle.marketzone.authentication.Security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.kapelle.marketzone.authentication.user.Model.RoleEntity;
import com.kapelle.marketzone.authentication.user.Model.UserEntity;

public class UserInfo implements UserDetails {
    
    private UserEntity user;
    
    
	public UserInfo(UserEntity user) {
        this.user = user;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        String ROLE_PERFIX = "ROLE_";
        Collection<RoleEntity> roles = user.getRoles();
        List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
        for(RoleEntity role: roles){
            authorities.add(new SimpleGrantedAuthority(ROLE_PERFIX + role.getName()));
        }
        return authorities;
    }

    @Override
    public String getUsername() {
        return user.getUsername();
    }

    @Override
    public String getPassword() {
        return user.getPassword();
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }
    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}
