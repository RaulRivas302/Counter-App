package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import com.example.demo.model.UserRegistration;
import com.example.demo.repository.UserRepo;

import java.util.Map;


@RestController
public class RegistrationController {

    @Autowired
    UserRepo repo;

    @RequestMapping("/")
    public ModelAndView home() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("Registration_Form");
        return mv;
    }

    @RequestMapping("/AlreadyLogin")
    public ModelAndView alreadyLogin() {
        return new ModelAndView("Login_Form");
    }

    @RequestMapping("/Registration")
    public ModelAndView registration(UserRegistration reg) {
        reg.setCounter(0); 
        repo.save(reg);
        return new ModelAndView("redirect:/login");
    }

    @RequestMapping("/Login")
    public ModelAndView login(String email, String password) {
        ModelAndView mv = new ModelAndView("redirect:/login");

        UserRegistration user = repo.findByEmailAndPassword(email, password);

        if (user != null) {
            String msg = "Login Successful";
            mv.addObject("message", user.getUname());
            mv.setViewName("view");
            return new ModelAndView("redirect:/home?userName=" + user.getUname() + "&counter=" + user.getCounter());
        } else {
            String msg = "Sorry You entered an incorrect email or password";
            mv.addObject("message", msg);
            mv.setViewName("error");
        }

        return mv;
    }

    @PostMapping("/updateCounter")
    public @ResponseBody String updateCounter(@RequestBody Map<String, Object> payload) {
        String uname = (String) payload.get("uname");
        int counter = (Integer) payload.get("counter");

        UserRegistration user = repo.findByUname(uname);
        if (user != null) {
            user.setCounter(counter);
            repo.save(user);
            return "Counter updated successfully";
        } else {
            return "User not found";
        }
    }
    
    @RequestMapping("/Logout")
    public ModelAndView logout() {
        return new ModelAndView("redirect:/login");
    }
    
    @RequestMapping("/home")
    public ModelAndView homePage() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("home");
        return mv;
    }
    @RequestMapping("/login")
    public ModelAndView loginpage() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("Login_Form");
        return mv;
    }
}
