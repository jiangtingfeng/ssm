package com.how2java.controller.admin;

import com.how2java.pojo.Category;
import com.how2java.service.CategoryService;
import com.how2java.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class adminIndex {

    @Autowired
    CategoryService categoryService;

    @RequestMapping("/adminLogin")
    public Object adminLogin() {
        return "login";
    }

    @RequestMapping("/category")
    public ModelAndView jumpToAdmin(Page page) {
        ModelAndView mav = new ModelAndView("category");
        return mav;
    }

}
