package com.tylercako.track531.controller.views

import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.GetMapping

@Controller
class HomeController {

    @GetMapping("/")
    fun getHome(): String {
        return "home";
    }
}