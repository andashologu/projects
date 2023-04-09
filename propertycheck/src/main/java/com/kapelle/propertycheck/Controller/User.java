package com.kapelle.propertycheck.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;

import com.kapelle.propertycheck.Model.UserEntity;
import com.kapelle.propertycheck.Model.UserRepository;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class User{

    @Autowired UserRepository userRepository;

    @Autowired AuthenticationProvider authenticationProvider;

    @Autowired PasswordEncoder passwordEncoder;

    @GetMapping("login")//login PostMapping is supported by Security
    public String login() {
        return "login";
    }
    @PostMapping("/login_failure_handler")
	public String loginFailureHandler(Model model){
        model.addAttribute("message", "Invalid username or password");
        return "login";
	}
    @PostMapping("/login_success_handler")
	public String loginSuccessHandler(){
        return "redirect:/";
	}
    @GetMapping("signup")
    public String signup() {
        return "signup";
    }
    @PostMapping("signup")
	public String getSignup(@ModelAttribute("user") @Validated UserEntity user , BindingResult result, RedirectAttributes attr, HttpServletRequest request, HttpServletResponse response) {
        if (result.hasErrors()) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            System.out.println("errors: "+result.getAllErrors());
            attr.addFlashAttribute("org.springframework.validation.BindingResult.user", result);
            attr.addFlashAttribute("user", user);
            return "redirect:/signup";
        }
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        userRepository.save(user);
        autoLogin(user,request);
		return "redirect:/";
	}
    @PostMapping("/admin")
	public String admin(){
        System.out.println("hello Admin");
        return "redirect:/";
	}
    private void autoLogin(UserEntity user, HttpServletRequest request){
        try {
            UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(user.getUsername(), request.getParameter("password"));
            token.setDetails(new WebAuthenticationDetails(request));
            Authentication authentication = this.authenticationProvider.authenticate(token);
            SecurityContextHolder.getContext().setAuthentication(authentication);
        } catch (Exception e) {
            SecurityContextHolder.getContext().setAuthentication(null);
        }
    }
}
