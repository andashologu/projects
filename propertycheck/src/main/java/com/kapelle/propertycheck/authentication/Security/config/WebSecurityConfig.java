package com.kapelle.propertycheck.authentication.Security.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.context.DelegatingSecurityContextRepository;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.security.web.context.RequestAttributeSecurityContextRepository;
import org.springframework.security.web.context.SecurityContextRepository;

import com.kapelle.propertycheck.authentication.user.Service.UserInfoService;

@Configuration 
@EnableWebSecurity 
public class WebSecurityConfig{ 
    
    @Bean 
    public UserDetailsService userDetailsService() { 
        return new UserInfoService(); 
    }

    @Bean
    BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    DaoAuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(userDetailsService());
        authProvider.setPasswordEncoder(passwordEncoder());
        return authProvider;
    } 

    @Bean
    public SecurityContextRepository securityContextRepository() {
      return new DelegatingSecurityContextRepository(
          new RequestAttributeSecurityContextRepository(),
          new HttpSessionSecurityContextRepository()
      );
    }

    @Bean 
    public SecurityFilterChain filterChain(HttpSecurity http, SecurityContextRepository securityContextRepository) throws Exception {
        http
            .authorizeHttpRequests()
                .requestMatchers("/**").permitAll()
                .requestMatchers("/admin/**").hasRole("ADMIN")
                .requestMatchers("/user/**").hasRole("USER") // url such as /user/add/post
            .and()
            .formLogin()
                .loginPage("/login").permitAll()
                .successForwardUrl("/login_success_handler")//support POST method
                .failureForwardUrl("/login_failure_handler")
            .and()
            .rememberMe(me -> me.key("KSESSIONLGN")
                .rememberMeParameter("rememberMe")
                .rememberMeCookieName("rememberlogin"))
            .logout(logout -> logout.permitAll()
                .deleteCookies("KSESSIONLGN"))
            .securityContext()
                .securityContextRepository(securityContextRepository)
            .and()
            .csrf().disable();
            //.csrf(withDefaults()).disable();
            //.csrf(withDefaults());
            return http.build();
    } 
}