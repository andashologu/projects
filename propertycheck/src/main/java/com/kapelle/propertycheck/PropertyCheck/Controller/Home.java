package com.kapelle.propertycheck.PropertyCheck.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.stereotype.Controller;

@Controller
public class Home {

    @GetMapping("/")
    public String index(){
        return "home";
    }
    @GetMapping("/post/{id}")
    public String index(@PathVariable("id") String username){
        return "posts/item";
    }
} 
