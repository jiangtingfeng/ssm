package com.how2java.controller.admin.order;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.how2java.Vo.OrderAndCount;
import com.how2java.Vo.ProductAndNumber;
import com.how2java.pojo.Count;
import com.how2java.pojo.UserOrder;
import com.how2java.pojo.Product;
import com.how2java.service.CountService;
import com.how2java.service.UserOrderService;
import com.how2java.service.ProductService;
import com.how2java.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.Date;
import java.util.LinkedList;
import java.util.List;

@Controller
public class OrderController {

    @Autowired
    private UserOrderService orderService;

    @Autowired
    private ProductService productService;

    @Autowired
    private CountService countService;
    @RequestMapping("/admin_order_list")
    public ModelAndView orderList(@RequestParam(value = "start",defaultValue = "1") int start) {
        ModelAndView modelAndView = new ModelAndView("orderList");
        List<UserOrder> orderList = orderService.list();
        List<OrderAndCount> orderAndCounts = new LinkedList<>();
        orderList.forEach(list->{
            List<ProductAndNumber> productAndNumbers = new LinkedList<>();
            OrderAndCount orderAndCount = new OrderAndCount();
            List<Count> counts = countService.getByOid(list.getId());
            counts.forEach(count->{
                ProductAndNumber productAndNumber = new ProductAndNumber();
                Product product = productService.getById(count.getPid());
                productAndNumber.setProductPic(product.getProductPic());
                productAndNumber.setProductName(product.getProductName());
                productAndNumber.setId(product.getId());
                productAndNumber.setPrice(product.getPrice());
                productAndNumber.setNumberOfBuy(count.getNumber());
                productAndNumbers.add(productAndNumber);
            });
            orderAndCount.setOrder(list);
            orderAndCount.setProductAndNumbers(productAndNumbers);
            orderAndCounts.add(orderAndCount);
        });
        PageHelper.startPage(start, Page.COUNT);
        PageInfo<OrderAndCount> orderAndCountPageInfo = new PageInfo<>(orderAndCounts,Page.COUNT);
        modelAndView.addObject("list",orderAndCountPageInfo);
        return modelAndView;
    }

    @RequestMapping("/admin_order_delivery")
    public ModelAndView orderDeliverty(@RequestParam(value = "id")int id,@RequestParam(value = "start",defaultValue = "1")int start){
        ModelAndView modelAndView = new ModelAndView("orderList");
        UserOrder order = orderService.getById(id);
        order.setSendTime(new Date());
        int k = 4;
        order.setStatus(k);
        if(orderService.update(order) != 0) {
            modelAndView.addObject("message_order","发货成功！");
        }
        List<UserOrder> orderList = orderService.list();
        List<OrderAndCount> orderAndCounts = new LinkedList<>();
        orderList.forEach(list->{
            List<ProductAndNumber> productAndNumbers = new LinkedList<>();
            OrderAndCount orderAndCount = new OrderAndCount();
            List<Count> counts = countService.getByOid(list.getId());
            counts.forEach(count->{
                ProductAndNumber productAndNumber = new ProductAndNumber();
                Product product = productService.getById(count.getPid());
                productAndNumber.setProductPic(product.getProductPic());
                productAndNumber.setProductName(product.getProductName());
                productAndNumber.setId(product.getId());
                productAndNumber.setPrice(product.getPrice());
                productAndNumber.setNumberOfBuy(count.getNumber());
                productAndNumbers.add(productAndNumber);
            });
            orderAndCount.setOrder(list);
            orderAndCount.setProductAndNumbers(productAndNumbers);
            orderAndCounts.add(orderAndCount);
        });
        PageHelper.startPage(start, Page.COUNT);
        PageInfo<OrderAndCount> orderAndCountPageInfo = new PageInfo<>(orderAndCounts,Page.COUNT);
        modelAndView.addObject("list",orderAndCountPageInfo);
        return modelAndView;
    }
}
