package com.kapelles.inc.TZm.authentication.Security.config;

import java.util.Arrays;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Scope;
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
import org.springframework.security.web.servlet.util.matcher.MvcRequestMatcher;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.servlet.handler.HandlerMappingIntrospector;

import com.kapelles.inc.TZm.authentication.user.Service.UserInfoService;

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
    public SecurityFilterChain securityFilterChain(HttpSecurity http, MvcRequestMatcher.Builder mvc, SecurityContextRepository securityContextRepository) throws Exception {
    
        //spring security forms already take care of this...
        //CsrfTokenRequestAttributeHandler requestHandler = new CsrfTokenRequestAttributeHandler();
        //requestHandler.setCsrfRequestAttributeName("_csrf");

        http
            .authorizeHttpRequests((authorize) -> authorize
                .requestMatchers(mvc.pattern("/admin/**")).hasRole("ADMIN")//if user roles are not configured correctly, these urls will not work
                .requestMatchers(mvc.pattern("/user/**")).hasRole("USER") // url such as /user/editor or add/post
                .requestMatchers(mvc.pattern("/chat"), mvc.pattern( "chat/**")).authenticated()
                .anyRequest().permitAll()
            )
            .formLogin((form) -> form
                .loginPage("/login").permitAll()
                .failureForwardUrl("/login_failure_handler") //support POST method
                //success handler not implemented to allow website (default) to continue to previous url
                //A modal will be required for pages that allow all users
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
            .csrf((csrf) -> csrf
                .ignoringRequestMatchers(mvc.pattern("/ws/**"))
                //.csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse())
                //.csrfTokenRequestHandler(requestHandler)
            )
            .headers((headers) -> headers
                .frameOptions((frameOptions) -> frameOptions.sameOrigin())
            );
        return http.build();
    }

    @Scope("prototype")
	@Bean
	MvcRequestMatcher.Builder mvc(HandlerMappingIntrospector introspector) {
		return new MvcRequestMatcher.Builder(introspector);
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