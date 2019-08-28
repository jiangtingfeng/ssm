package com.how2java.controller;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.how2java.Vo.ProductVo;
import com.how2java.pojo.Category;
import com.how2java.pojo.Product;
import com.how2java.pojo.User;
import com.how2java.service.CategoryService;
import com.how2java.service.ProductService;
import com.how2java.service.UserService;
import com.how2java.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

@Controller
public class loginController {

    @Autowired
    UserService userService;

    @Autowired
    CategoryService categoryService;

    @Autowired
    private ProductService productService;

    @RequestMapping("/forelogin")
    public ModelAndView login(@RequestParam(value = "start",defaultValue = "1")int start, User user, HttpServletRequest request) throws Exception {
        if(userService.getByUser(user) == null) {
            ModelAndView mav = new ModelAndView("login");
            mav.addObject("message","账号或密码错误，请重新登入！");
            return mav;
        }
        if("admin".equals(user.getName()) && "123456".equals(user.getPassword())){
            ModelAndView mav = new ModelAndView("category");
            List<Category> cs = categoryService.list();
            PageHelper.startPage(start,Page.COUNT);
            PageInfo<Category> categoryPageInfo = new PageInfo<>(cs,Page.COUNT);
            mav.addObject("list",categoryPageInfo);
            return mav;
        }
        ModelAndView mav = new ModelAndView("indexLogined");
        HttpSession session = request.getSession();
        session.setAttribute("user",user);
        List<Category> categoryList = categoryService.list();
        mav.addObject("categoryList",categoryList);
        List<ProductVo> productVoList = new LinkedList<>();
        categoryList.forEach(category -> {
            ProductVo productVo = new ProductVo();
            List<Product> products = productService.list(category.getId());
            List<Product> productList = new LinkedList<>();
            productVo.setCategory(category);
            if(products != null){
                int size = products.size();
                int k = size < 5 ? size : 5;
                productList.addAll(products.subList(0,k));
                productVo.setProducts(productList);
            }
            productVoList.add(productVo);
        });
        mav.addObject("productVoList",productVoList);
        return mav;
    }

    @RequestMapping("/foreregister")
    public Object register(User user) throws Exception {
        ModelAndView mav = new ModelAndView();
        if(user == null || userService.getByName(user.getName()) != null) {
            mav.addObject("message","用户名已存在！请重新取名");
            mav.setViewName("register");
            return mav;
        }
        if(userService.getByPboneNumber(user.getPhoneNumber()) != null) {
            mav.addObject("message","手机号码已存在！请重新输入");
            mav.setViewName("register");
            return mav;
        }
        user.setCreateTime(new Date());
        if(userService.insert(user) == 0) {
            mav.addObject("message","注册失败！");
            mav.setViewName("register");
            return mav;
        }
        return "login";
    }
}
