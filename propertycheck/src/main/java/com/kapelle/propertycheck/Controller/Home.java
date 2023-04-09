package com.kapelle.propertycheck.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.stereotype.Controller;

@Controller
public class Home {

    @GetMapping("/")
    public String index(){
        return "home";
    }
} 
