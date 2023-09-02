package com.kapelles.inc.TZm.authentication.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails; 
import org.springframework.security.core.userdetails.UserDetailsService; 
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.kapelles.inc.TZm.security.UserInfo;
import com.kapelles.inc.TZm.authentication.user.model.UserEntity;
import com.kapelles.inc.TZm.authentication.user.model.UserRepository;

public class UserInfoService implements UserDetailsService { 
    
    @Autowired 
    private UserRepository userRepository; 
    
    @Override 
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException { 
        UserEntity user = userRepository.findByUsernameIgnoreCase(username); 
        if (user == null) { 
            user = userRepository.findByEmailIgnoreCase(username); 
            if(user == null)
                throw new UsernameNotFoundException("Could not find user");
        } 
        return new UserInfo(user); 
    } 
    
    
}