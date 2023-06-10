package com.kapelle.inc.tradezonemarket.authentication.Security.config;

import java.util.Arrays;

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
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import com.kapelle.inc.tradezonemarket.authentication.user.Service.UserInfoService;

@Configuration 
@EnableWebSecurity 
public class WebSecurityConfig { 
    
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
    
        //spring security forms already take care of this...
        //CsrfTokenRequestAttributeHandler requestHandler = new CsrfTokenRequestAttributeHandler();
        //requestHandler.setCsrfRequestAttributeName("_csrf");

        http
            .authorizeHttpRequests((authorize) -> authorize
                .requestMatchers("/admin/**").hasRole("ADMIN")//user roles has not been configured corrctly so these urls will not work
                .requestMatchers("/user/**").hasRole("USER") // url such as /user/add/post
                .requestMatchers("/chat", "chat/**").authenticated()
                .anyRequest().permitAll()
            )
            .formLogin((form) -> form
                .loginPage("/login").permitAll()
                //.successForwardUrl("/login_success_handler")//support POST method
                .failureForwardUrl("/login_failure_handler")
                //success handler not implemented to allow webwsite (default) to continue to previous url
                //we'll need modal for pages that allow all users
            )
            .rememberMe(me -> me
                .key("KSESSIONLGN")
                .rememberMeParameter("rememberMe")
                .rememberMeCookieName("rememberlogin")
            )
            .logout(logout -> logout
                .permitAll()
                .deleteCookies("KSESSIONLGN")
            )
            .securityContext(context -> context
                .securityContextRepository(securityContextRepository))
            //spring security forms already take care of this...
            .csrf((csrf) -> csrf
                .ignoringRequestMatchers("/ws/**")
                //.csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse())
                //.csrfTokenRequestHandler(requestHandler)
            )
            .headers((headers) -> headers
                .frameOptions((frameOptions) -> frameOptions.sameOrigin())
            );
        return http.build();
    } 

    @Bean
    CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();
        configuration.setAllowedOrigins(Arrays.asList("http://localhost:9090"));//allow websocket iframe after login
        configuration.setAllowedMethods(Arrays.asList("GET","POST"));
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);
        return source;
    }
}