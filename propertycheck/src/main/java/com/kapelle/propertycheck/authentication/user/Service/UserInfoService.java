package com.kapelle.propertycheck.authentication.user.Service;

import org.springframework.beans.factory.annotation.Autowired; 
import org.springframework.security.core.userdetails.UserDetails; 
import org.springframework.security.core.userdetails.UserDetailsService; 
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.kapelle.propertycheck.authentication.Security.UserInfo;
import com.kapelle.propertycheck.authentication.user.Model.UserEntity;
import com.kapelle.propertycheck.authentication.user.Model.UserRepository;

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