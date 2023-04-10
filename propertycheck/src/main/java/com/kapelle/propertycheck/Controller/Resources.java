package com.kapelle.propertycheck.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.stereotype.Controller;

@Controller
public class Resources {

    @GetMapping("/post/{id}")
    public String index(@PathVariable("id") String username){
        return "item";
    }
} 
