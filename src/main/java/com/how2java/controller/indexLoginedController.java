package com.how2java.controller;

import com.how2java.Vo.ProductVo;
import com.how2java.pojo.Category;
import com.how2java.pojo.Product;
import com.how2java.pojo.User;
import com.how2java.service.CategoryService;
import com.how2java.service.ProductService;
import com.how2java.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.LinkedList;
import java.util.List;

@Controller
public class indexLoginedController {

    @Autowired
    CategoryService categoryService;

    @Autowired
    private ProductService productService;

    @Autowired
    private UserService userService;

    @RequestMapping("/indexLogined")
    public Object indexLogined(Model model) {
        List<Category> categoryList = categoryService.list();
        model.addAttribute("categoryList",categoryList);
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
        model.addAttribute("productVoList",productVoList);
        return "indexLogined";
    }
    @RequestMapping("/index")
    public Object index(Model model) {
        List<Category> categoryList = categoryService.list();
        model.addAttribute("categoryList",categoryList);
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
        model.addAttribute("productVoList",productVoList);
        return "index";
    }




    @RequestMapping("/login")
    public Object forelogin() {
        return "login";
    }


    @RequestMapping("forecheckLogin")
    @ResponseBody
    public String checkLogin( HttpSession session) {
        User user =(User)  session.getAttribute("user");
        if(null!=user)
            return "success";
        return "fail";
    }

    @RequestMapping("foreloginAjax")
    @ResponseBody
    public String  check(HttpServletRequest request){
            String name = request.getParameter("name");
            if(userService.getByName(name) != null) {
                User byName = userService.getByName(name);
                request.getSession().setAttribute("user",byName);
                return "success";
            }
            return "fail";
    }

    @RequestMapping("/forelogout")
    public ModelAndView forelogout(HttpSession session) {
        ModelAndView mav = new ModelAndView("login");
        session.removeAttribute("user");
        return mav;
    }
}
