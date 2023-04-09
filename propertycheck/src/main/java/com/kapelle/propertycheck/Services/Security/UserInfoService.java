package com.kapelle.propertycheck.Services.Security;

import org.springframework.beans.factory.annotation.Autowired; 
import org.springframework.security.core.userdetails.UserDetails; 
import org.springframework.security.core.userdetails.UserDetailsService; 
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.kapelle.propertycheck.Model.UserEntity;
import com.kapelle.propertycheck.Model.UserRepository;
import com.kapelle.propertycheck.Security.UserInfo;

public class UserInfoService implements UserDetailsService { 
    @Autowired 
    private UserRepository userRepository; 
    
    @Override public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException { 
        UserEntity user = userRepository.findByUsername(username); 
        if (user == null) { 
            throw new UsernameNotFoundException("Could not find user"); 
        } 
        return new UserInfo(user); 
    } 
}