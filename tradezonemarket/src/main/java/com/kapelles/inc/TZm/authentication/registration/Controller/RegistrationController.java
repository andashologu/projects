package com.kapelles.inc.TZm.authentication.registration.Controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.context.SecurityContextHolderStrategy;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.security.web.context.SecurityContextRepository;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kapelles.inc.TZm.authentication.user.Model.RoleEntity;
import com.kapelles.inc.TZm.authentication.user.Model.RoleRepository;
import com.kapelles.inc.TZm.authentication.user.Model.UserEntity;
import com.kapelles.inc.TZm.authentication.user.Model.UserRepository;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class RegistrationController {

    @Autowired UserRepository userRepository;

    @Autowired RoleRepository roleRepository;

    @Autowired AuthenticationProvider authenticationProvider;

    @Autowired PasswordEncoder passwordEncoder;

    @GetMapping("signup")
    public String signup() {
        return "authentication/signup";
    }
    @PostMapping("signup")
	public String getSignup(@ModelAttribute("user") @Validated UserEntity user , BindingResult result, RedirectAttributes attr, HttpServletRequest request, HttpServletResponse response){
        if (result.hasErrors()) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            attr.addFlashAttribute("org.springframework.validation.BindingResult.user", result);
            attr.addFlashAttribute("user", user);
            return "redirect:/signup";
        }
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        RoleEntity userRole = new RoleEntity("USER");
        List<RoleEntity> roles = new ArrayList<>();
        roles.add(userRole);
        user.setRoles(roles);
        //user.setRoles(Arrays.asList(new RoleEntity("USER")));
        userRepository.save(user);
        autoLogin(user,request, response);
		return "redirect:/";
	}
    private void autoLogin(UserEntity user, HttpServletRequest request, HttpServletResponse response) {
        SecurityContextRepository securityContextRepository = new HttpSessionSecurityContextRepository();
        try {
            UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(user.getUsername(), request.getParameter("password"));
            token.setDetails(new WebAuthenticationDetails(request));
            Authentication authentication = this.authenticationProvider.authenticate(token);
            SecurityContextHolderStrategy securityContextHolderStrategy = SecurityContextHolder.getContextHolderStrategy();
            SecurityContext context = securityContextHolderStrategy.createEmptyContext();
            context.setAuthentication(authentication);
            securityContextHolderStrategy.setContext(context);
            securityContextRepository.saveContext(context, request, response);
        } catch (Exception e) {
            SecurityContextHolder.getContext().setAuthentication(null);
        }
    }
}
