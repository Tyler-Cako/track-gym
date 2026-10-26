package com.tylercako.track531.controller.view

import com.tylercako.track531.model.db.User
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.ModelAttribute
import java.util.Date

@Controller
class HomeController {

    @GetMapping("/")
    fun getHome(): String {
        return "home";
    }

    @ModelAttribute("timeBasedGreeting")
    fun getGreeting(): String {
        return Date.from(java.time.Instant.now()).toString();
    }

    @ModelAttribute("user")
    fun getUser(): User {
        val user = User(1234, "Tyler");
        return user;
    }
}