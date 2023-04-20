package com.kapelle.propertycheck.ADMIN.Controller;

import org.springframework.web.bind.annotation.PostMapping;

public class AdminControl {
    @PostMapping("/admin")
	public String admin(){
        System.out.println("hello Admin");
        return "redirect:/";
	}
}
