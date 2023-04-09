package com.kapelle.propertycheck.config;

import org.springframework.context.annotation.*; 
import org.springframework.security.authentication.dao.*; 
import org.springframework.security.config.annotation.web.builders.*; 
import org.springframework.security.config.annotation.web.configuration.*; 
import org.springframework.security.core.userdetails.*; 
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import com.kapelle.propertycheck.Services.Security.UserInfoService;

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
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception { 
        http
            .authorizeHttpRequests( (authorize) -> authorize
                .requestMatchers("/**").permitAll()
                .requestMatchers("/admin/**").hasRole("ADMIN")
                .requestMatchers("/user/**").hasRole("USER") // url such as /user/add/post
            )
            .formLogin()
                .loginPage("/login").permitAll() 
                .successForwardUrl("/login_success_handler")//support POST method
                .failureForwardUrl("/login_failure_handler")//support POST method
                .and()
            .rememberMe().key("KSESSIONLGN")
                .rememberMeParameter("rememberMe")
                .rememberMeCookieName("rememberlogin")//name of the cookie
                .and() 
            .logout().permitAll()
                .deleteCookies("KSESSIONLGN")
                .logoutSuccessUrl("/")
                .and()
            .csrf().disable();
            return http.build();


            /* *.antMatchers( "/**").permitAll()
            .and() 
            .formLogin()
            .loginPage("/login").permitAll()//support POST method /*Post mapping for this url must not be rewritten in the controller */
            /* .successForwardUrl("/login_success_handler")//support POST method
            .failureHandler(failureHandler)
            .and()
            .rememberMe().key("sessionlogin")
            .rememberMeParameter("rememberMe")
            .rememberMeCookieName("rememberlogin")//name of the cookie
            .and() 
            .logout()
            .logoutSuccessUrl("/").permitAll()
            .and()
            .csrf().disable();*/
    } 
}