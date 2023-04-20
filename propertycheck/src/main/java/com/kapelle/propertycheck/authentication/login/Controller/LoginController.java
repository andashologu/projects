package com.kapelle.propertycheck.authentication.login.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import jakarta.servlet.http.HttpServletResponse;

@Controller
public class LoginController {
    @GetMapping("login")//login PostMapping is supported by Security
    public String login() {
		    return "authentication/login";
	}
    @PostMapping("/login_failure_handler")
	public String loginFailureHandler(Model model, HttpServletResponse response){
        model.addAttribute("message", "Invalid username or password");
        response.setStatus(HttpServletResponse.SC_FORBIDDEN);
        return "authentication/login";
	}
    @PostMapping("/login_success_handler")
	public String loginSuccessHandler(){
        return "redirect:/";
	}
}