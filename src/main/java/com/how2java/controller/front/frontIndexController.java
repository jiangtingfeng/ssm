package com.how2java.controller.front;

import com.how2java.Vo.ProductAndNumber;
import com.how2java.Vo.ProductNumberVo;
import com.how2java.pojo.*;
import com.how2java.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.concurrent.atomic.AtomicBoolean;

@Controller
public class frontIndexController {


    @Autowired
    private CategoryService categoryService;

    @Autowired
    private ProductService productService;

    @Autowired
    private ProductPicService productPicService;

    @Autowired
    private UserOrderService userOrderService;

    @Autowired
    private CountService countService;

    @RequestMapping("/foreproduct")
    public ModelAndView forecategory(@RequestParam(value = "pid")int pid) {
        ModelAndView modelAndView = new ModelAndView("productDetail");
        List<Category> categoryList = categoryService.list();
        modelAndView.addObject("categoryList",categoryList);
        Product product = productService.getById(pid);
        Category category = categoryService.getById(product.getCid());
        modelAndView.addObject("categoryPic",category);
        modelAndView.addObject("product",product);
        List<ProductPic> productPicList = productPicService.getByPid(pid);
        modelAndView.addObject("productPicList",productPicList);
        return modelAndView;
    }

    @RequestMapping("forebuyone")
    public String buyone(int pid, int num, HttpSession session) {
        Product product = productService.getById(pid);
        int oiid = 0;
        User user = (User) session.getAttribute("user");
        UserOrder order = userOrderService.getByBuyerName(user.getName());
        /*
        * 判断是否已存在相应购买ID
        * */
        boolean found = false;
            List<Count> countList = countService.getByOid(order.getId());
            if(countList != null) {
                found = true;
                countList.forEach(count->{
                    if(count.getPid().intValue() == product.getId()) {
                        order.setProductNumber(order.getProductNumber()+1);
                        order.setTotalMoney(order.getTotalMoney()+product.getLowerPrice());
                        count.setNumber(count.getNumber()+num);
                    }
                });
            }
/*
* 如果没有对应的ID则新增订单
* */
        if(!found) {
            /*
            * 添加userorder
            * */
            UserOrder userOrder = new UserOrder();
            userOrder.setBuyerName(user.getName());
            userOrder.setSetTime(new Date());
            userOrder.setTotalMoney(product.getLowerPrice());
            userOrder.setMobile(Integer.valueOf(user.getPhoneNumber()));
            userOrderService.insert(userOrder);
            oiid = userOrder.getId();
            /*
            * 添加count
            * */
            Count count = new Count();
            count.setPid(product.getId());
            count.setOid(order.getId());
            count.setNumber(num);
            countService.insert(count);
        }
        return "redirect:forebuy?oiid="+oiid;
    }

    @RequestMapping("forebuy")
    public String buy(Model model, String[] oiid, HttpSession session){
        List<ProductNumberVo> productNumberVoList = new ArrayList<>();
        UserOrder userOrder = new UserOrder();
        for (String strid : oiid) {
            userOrder = userOrderService.getById(Integer.valueOf(strid));
            List<Count> countList = countService.getByOid(userOrder.getId());
            countList.forEach(count->{
                ProductNumberVo productNumberVo = new ProductNumberVo();
                Product product = productService.getById(count.getPid());
                productNumberVo.setProduct(product);
                productNumberVo.setNumber(count.getNumber());
                productNumberVoList.add(productNumberVo);
            });
        }
        model.addAttribute("userOrder",userOrder);
        model.addAttribute("productList",productNumberVoList);
        return "buy";
    }
}
