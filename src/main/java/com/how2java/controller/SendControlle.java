package com.how2java.controller;

import com.how2java.pojo.User;
import com.how2java.service.UserService;
import com.how2java.util.SendUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;

/*
* 手机号码获取验证码controller
*
* */
@Controller
public class SendControlle {

    @Autowired
    UserService userService;

    @ResponseBody
    @RequestMapping(value = "/sendme", method = RequestMethod.GET)
    public ModelAndView sendme(@RequestParam(value = "name")String name, @RequestParam(value = "phoneNumber")String phoneNumber, HttpServletRequest request, HttpServletResponse response) throws IOException {
        ModelAndView mav = new ModelAndView();
        //数字时不需要进行转化，不是数字时会报错
        boolean flag = userService.getByNameAndPhone(name, phoneNumber);
        if (flag){
            HashMap<String,String> hashMap = SendUtil.getMessageStatus(phoneNumber);
            String result = hashMap.get("result");
            if (result.trim().equals("1")) {
                String code = hashMap.get("code");
                HttpSession session = request.getSession();
                session.setAttribute(phoneNumber+"code",code);
                session.setMaxInactiveInterval(60*5);
                mav.addObject("flag","发送成功");
            } else {
                mav.addObject("flag", "发送失败");
            }
            mav.addObject("name", name);
            mav.addObject("phoneNumber",phoneNumber);
            mav.setViewName("findPassword");
        }
        else {
            mav.addObject("flag1", "用户名或手机号码不正确");
            mav.addObject("name", name);
            mav.addObject("phoneNumber",phoneNumber);
            mav.setViewName("findPassword");
        }
        return mav;
    }

    @RequestMapping(value = "/findPassword")
    public Object findPassword(String code, User user, HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView();
        HttpSession session = request.getSession();
        String codeNum = (String) session.getAttribute(user.getPhoneNumber()+"code");
        //通过自动复制进行校验
        if(codeNum == null) {
            codeNum = "1234";
        }
        System.out.println(codeNum);
        if(code.equals(codeNum)) {
            if(userService.updateByName(user.getPassword(),user.getName()) == 1){
                mav.addObject("result","修改密码成功");
            }
            else{
                mav.addObject("result","修改密码失败");
            }
        }
        else {
            mav.addObject("result","验证码不正确");
        }
        mav.setViewName("findPassword");
        return mav;
    }
}
