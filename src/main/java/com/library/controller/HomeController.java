
package com.library.controller;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
	
    @GetMapping("/")
    public String home(Model model) {

        return "index"; // views/index.jsp 반환
    }

    @GetMapping("/index")
    public String indexPage(Model model) {
        return home(model); // home() 메서드를 호출하여 Model에 데이터를 담고 동일한 JSP를 반환
    }

    @GetMapping("/library")
    public String myLibrary(Model model) {
        return "mylibrary"; // views/mylibrary.jsp 반환
    }
}