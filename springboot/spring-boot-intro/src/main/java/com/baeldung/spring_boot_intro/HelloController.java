package com.baeldung.spring_boot_intro;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
    @GetMapping("/")
    public String home() {
        return "index";  // maps to src/main/resources/templates/index.html
    }
}
