package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
@RequestMapping("/api/hello")
public class HelloControler {

    @Value("${owner}")
    private String owner;

    @GetMapping("/message")
    public String sayHello() {
        return "Hi, your property is: " + owner;
    }

}
