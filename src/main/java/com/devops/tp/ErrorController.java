package com.devops.tp;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/test")
public class ErrorController {

    @GetMapping("/error")
    public String triggerError() {
        throw new RuntimeException("Simulated error for monitoring"); //error de prueba
    }
}