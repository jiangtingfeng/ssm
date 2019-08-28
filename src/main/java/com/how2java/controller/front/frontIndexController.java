package com.how2java.controller.front;

import com.how2java.Vo.ProductNumberVo;
import com.how2java.enums.OrderStatusEnum;
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
            if(order != null ) {
                oiid = order.getId();
                List<Count> countList = countService.getByOid(order.getId());
                if(countList.size()==0) {
                    Count count = new Count();
                    count.setId(null);
                    count.setPid(product.getId());
                    count.setOid(order.getId());
                    count.setNumber(num);
                    if(countService.insert(count) != 1){
                        session.setAttribute("message","新增失败");
                    }
                }
                countList = countService.getByOid(order.getId());
                found = true;
                AtomicBoolean tag = new AtomicBoolean(false);
                tag.set(false);
                countList.forEach(count -> {
                    order.setProductNumber(order.getProductNumber() + num);
                    order.setTotalMoney(order.getTotalMoney() + product.getLowerPrice()*num);
                    if (count.getPid() == product.getId()) {
                        count.setNumber(count.getNumber() + num);
                        tag.set(true);
                    }
                });
                if(!tag.get()) {
                    Count count1 = new Count();
                    count1.setId(null);
                    count1.setPid(product.getId());
                    count1.setOid(order.getId());
                    count1.setNumber(num);
                    if(countService.insert(count1) != 1){
                        session.setAttribute("message","新增失败");
                    }
                }
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
            userOrder.setMobile(user.getPhoneNumber());
            userOrder.setUid(user.getId());
            userOrder.setProductNumber(num);
            userOrder.setStatus(OrderStatusEnum.ORDER.getFlag());
            userOrderService.insert(userOrder);
            userOrder = userOrderService.getByBuyerName(user.getName());
            oiid = userOrder.getId();
            /*
             * 添加count
             * */
            Count count = new Count();
            count.setPid(product.getId());
            count.setOid(userOrder.getId());
            count.setNumber(num);
            if(countService.insert(count) != 1){
                session.setAttribute("message","新增失败");
            }
        }
        return "redirect:forebuy?oiid="+oiid;
    }

    @RequestMapping("forebuy")
    public String buy(Model model, String[] oiid, HttpSession session){
        List<ProductNumberVo> productNumberVoList = new ArrayList<>();
        UserOrder userOrder = new UserOrder();
        for (String strid : oiid) {
            userOrder = userOrderService.getById(Integer.valueOf(strid).intValue());
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
        model.addAttribute("message",session.getAttribute("message"));
        return "buy";
    }
}
