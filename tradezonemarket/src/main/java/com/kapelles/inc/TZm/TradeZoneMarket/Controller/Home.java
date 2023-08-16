package com.kapelles.inc.TZm.TradeZoneMarket.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.kapelles.inc.TZm.authentication.user.Model.UserRepository;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller
public class Home {

    @Autowired UserRepository userRepository;

    @GetMapping("/")
    public String index(){
        return "home/index";
    }
    @GetMapping("/post/{id}")
    public String index(@PathVariable("id") String username){
        return "posts/item";
    }
    @GetMapping("/user/test")
    public String testingAuthorities(){
        return "authentication/test";
    }
    @GetMapping("/test")
    public String test(HttpServletRequest request){
        return "test";
    }
} 
