package com.kapelle.marketzone.ADMIN.Controller;

import org.springframework.web.bind.annotation.PostMapping;

public class AdminControl {
    @PostMapping("/admin")
	public String admin(){
        System.out.println("hello Admin");
        return "redirect:/";
	}
}
