package com.how2java.controller.admin.user;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.how2java.pojo.User;
import com.how2java.service.UserService;
import com.how2java.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping("/admin_user_list")
    public ModelAndView userList(@RequestParam(value = "start",defaultValue = "1")int start){
        ModelAndView modelAndView = new ModelAndView("userList");
        List<User> users = userService.list();
        PageHelper.startPage(start, Page.COUNT);
        PageInfo<User> userPageInfo = new PageInfo<>(users,Page.COUNT);
        System.out.println(userPageInfo.getPages());
        modelAndView.addObject("list",userPageInfo);
        return modelAndView;
    }
    @RequestMapping("/user_delete")
    public ModelAndView userDelete(@RequestParam(value = "start",defaultValue = "1")int start,@RequestParam(value = "id")int id){
        ModelAndView modelAndView = new ModelAndView("userList");
        if(userService.deleteById(id) != 0) {
                modelAndView.addObject("message","删除成功！");
        }
        List<User> users = userService.list();
        PageHelper.startPage(start, Page.COUNT);
        PageInfo<User> userPageInfo = new PageInfo<>(users,Page.COUNT);
        System.out.println(userPageInfo.getPages());
        modelAndView.addObject("list",userPageInfo);
        return modelAndView;
    }
}
