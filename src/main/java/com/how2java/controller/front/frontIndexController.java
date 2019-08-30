package com.how2java.controller.front;

import com.alibaba.druid.sql.visitor.functions.Char;
import com.how2java.Vo.ProductAndSellVo;
import com.how2java.Vo.ProductNumberVo;
import com.how2java.enums.OrderStatusEnum;
import com.how2java.enums.SortMehodEnum;
import com.how2java.pojo.*;
import com.how2java.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.crypto.Data;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
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

    @Autowired
    private  UserService userService;

    @Autowired
    private  PropertyService propertyService;

    @Autowired
    private CommentService commentService;


    @RequestMapping("/foreproduct")
    public ModelAndView foreproduct(@RequestParam(value = "pid")int pid) {
        ModelAndView modelAndView = new ModelAndView("productDetail");
        List<Category> categoryList = categoryService.list();
        modelAndView.addObject("categoryList",categoryList);
        Product product = productService.getById(pid);
        Category category = categoryService.getById(product.getCid());

        modelAndView.addObject("categoryPic",category);
        modelAndView.addObject("product",product);
        /*
        * 返回产品详情图片
        * */
        List<ProductPic> productPicList = productPicService.getByPid(pid);
        modelAndView.addObject("productPicList",productPicList);
        /*
        * 返回产品属性值
        * */
        List<Property> propertyList = propertyService.getByCid(category.getId());
        modelAndView.addObject("propertyList",propertyList);
        /*
        * 获取产品相应的销售量
        * */
        List<Count> countList = countService.getByPid(pid);
        int total = 0;
        for (Count count:countList) {
            total = total + count.getNumber();
        }
        modelAndView.addObject("total",total);
        /*
        * 获取产品评论信息
        * */
        List<Comment> commentList = commentService.list(pid);
        if(commentList != null) {
            commentList.forEach(comment -> {
                String name = comment.getUserName();
                char[] chars = name.toCharArray();
                String s = "";
                s = s + chars[0];
                for (int i = 1; i < chars.length - 1; i++) {
                    s = s + "*";
                }
                s = s + chars[chars.length - 1];
                comment.setUserName(s);
            });
        }
        modelAndView.addObject("commentList",commentList);
        return modelAndView;
    }

    @RequestMapping("foreaddCart")
    public String foreaddCart(HttpSession session,int pid, int num) {
        //更新产品库存
        Product product = productService.getById(pid);
        product.setNumber(product.getNumber() - num);
        productService.update(product);
        /*
         * 订单Id
         * */
        int oiid = 0;
        User user = (User) session.getAttribute("user");
        user = userService.getByName(user.getName());
        UserOrder order = userOrderService.getByBuyerName(user.getName());
        /*
         * 判断是否已存在相应购买ID
         * */
        boolean found = false;
        if(order != null ) {
            order.setProductNumber(order.getProductNumber() + num);
            order.setTotalMoney(order.getTotalMoney() + product.getLowerPrice() * num);
            int update = userOrderService.updateNumber(order);
            order.setStatus(OrderStatusEnum.ORDER.getFlag());
            if(update != 1) {
                session.setAttribute("message","更新订单失败！");
            }
            found = true;
            oiid = order.getId();
            List<Count> countList = countService.getByOid(order.getId());
            /*
             * 判断是否存在相应的计数
             * */
            if(countList.size()==0) {
                Count count = new Count();
                count.setId(null);
                count.setPid(product.getId());
                count.setOid(order.getId());
                count.setNumber(num);
                count.setCreateTime(new Date());
                count.setUid(user.getId());
                if(countService.insert(count) != 1){
                    session.setAttribute("message","新增失败");
                }
            }
            AtomicBoolean tag = new AtomicBoolean(false);
            tag.set(false);
            countList = countService.getByOid(order.getId());
            countList.forEach(count -> {
                if (count.getPid() == product.getId()) {
                    count.setNumber(count.getNumber() + num);
                    //更新
                    int update1 = countService.update(count);
                    if(update1 != 1) {
                        session.setAttribute("message","count更新失败！");
                    }
                    tag.set(true);
                }
            });
            if(!tag.get()) {
                Count count1 = new Count();
                count1.setId(null);
                count1.setPid(product.getId());
                count1.setOid(order.getId());
                count1.setNumber(num);
                count1.setCreateTime(new Date());
                count1.setUid(user.getId());
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
            userOrder.setTotalMoney(product.getLowerPrice() * num);
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
            count.setCreateTime(new Date());
            count.setUid(user.getId());
            if(countService.insert(count) != 1){
                session.setAttribute("message","新增失败");
            }
        }
        return "success";
    }

    @RequestMapping("/forecart")
    public String forecart(Model model,HttpSession session) {
        User user = (User) session.getAttribute("user");
        UserOrder userOrder = null;
        if(user != null) {
            userOrder = userOrderService.getByBuyerName(user.getName());
        }
        else {
            return "login";
        }
        List<Category> categoryList = categoryService.list();
        List<Category> categories = new LinkedList<>();
        int size = categoryList.size();
        int index = size <=4 ? size : 4;
        categories.addAll(categoryList.subList(0,index));
        model.addAttribute("categoryList",categories);
        model.addAttribute("userOrder",userOrder);
        List<ProductNumberVo> productNumberVoList = new ArrayList<>();
        List<Count> countList = countService.getByOid(userOrder.getId());
        countList.forEach(count -> {
            ProductNumberVo productNumberVo = new ProductNumberVo();
            Product product = productService.getById(count.getPid());
            productNumberVo.setProduct(product);
            productNumberVo.setNumber(count.getNumber());
            productNumberVoList.add(productNumberVo);
        });
        model.addAttribute("productNumberVoList",productNumberVoList);
        return "forecart";
    }


    @RequestMapping("forebuyone")
    public String buyone(int pid, int num, HttpSession session) {
        //更新产品库存
        Product product = productService.getById(pid);
        product.setNumber(product.getNumber() - num);
        productService.update(product);
        /*
        * 订单Id
        * */
        int oiid = 0;
        User user = (User) session.getAttribute("user");
        user = userService.getByName(user.getName());
        UserOrder order = userOrderService.getByBuyerName(user.getName());
        /*
        * 判断是否已存在相应购买ID
        * */
        boolean found = false;
        if(order != null ) {
            order.setProductNumber(order.getProductNumber() + num);
            order.setTotalMoney(order.getTotalMoney() + product.getLowerPrice() * num);
            int update = userOrderService.updateNumber(order);
            order.setStatus(OrderStatusEnum.ORDER.getFlag());
            if(update != 1) {
                session.setAttribute("message","更新订单失败！");
            }
            found = true;
            oiid = order.getId();
            List<Count> countList = countService.getByOid(order.getId());
            /*
            * 判断是否存在相应的计数
            * */
            if(countList.size()==0) {
                Count count = new Count();
                count.setId(null);
                count.setPid(product.getId());
                count.setOid(order.getId());
                count.setNumber(num);
                count.setCreateTime(new Date());
                count.setUid(user.getId());
                if(countService.insert(count) != 1){
                     session.setAttribute("message","新增失败");
                }
            }
             AtomicBoolean tag = new AtomicBoolean(false);
             tag.set(false);
             countList = countService.getByOid(order.getId());
             countList.forEach(count -> {
                if (count.getPid() == product.getId()) {
                     count.setNumber(count.getNumber() + num);
                     //更新
                    int update1 = countService.update(count);
                    if(update1 != 1) {
                        session.setAttribute("message","count更新失败！");
                    }
                    tag.set(true);
                    }
             });
             if(!tag.get()) {
               Count count1 = new Count();
               count1.setId(null);
               count1.setPid(product.getId());
               count1.setOid(order.getId());
               count1.setNumber(num);
               count1.setCreateTime(new Date());
               count1.setUid(user.getId());
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
            userOrder.setTotalMoney(product.getLowerPrice() * num);
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
            count.setCreateTime(new Date());
            count.setUid(user.getId());
            if(countService.insert(count) != 1){
                session.setAttribute("message","新增失败");
            }
        }
        return "redirect:forebuy?oiid="+oiid;
    }

    @RequestMapping("forebuy")
    public String buy(Model model, Integer[] oiid, HttpSession session){
        List<ProductNumberVo> productNumberVoList = new ArrayList<>();
        UserOrder userOrder = new UserOrder();
        for (Integer strid : oiid) {
            userOrder = userOrderService.getById(strid);
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

    @RequestMapping("/forecreateOrder")
    public ModelAndView forecreateOrder(UserOrder userOrder) {
        ModelAndView mav = new ModelAndView("payPage");
        UserOrder userOrder1 = userOrderService.getById(userOrder.getId());
        userOrder1.setReceiver(userOrder.getReceiver() == null ? null : userOrder.getReceiver());
        userOrder1.setAddress(userOrder.getAddress() == null ? null : userOrder.getAddress());
        userOrder1.setPost(userOrder.getPost() == null ? null : userOrder.getPost());
        userOrder1.setMobile(userOrder.getMobile() == null ? userOrder1.getMobile() : userOrder.getMobile());
        userOrder1.setUserMessage(userOrder.getUserMessage());
        if(!StringUtils.isEmpty(userOrder.getUserMessage())) {
            List<Count> countList = countService.getByOid(userOrder1.getId());
            if(countList != null) {
                countList.forEach(count->{
                    Comment comment = new Comment();
                    comment.setMessage(userOrder1.getUserMessage());
                    comment.setUpdateDate(new Date());
                    comment.setUserName(userOrder1.getBuyerName());
                    comment.setPid(count.getPid());
                    if(commentService.insert(comment) != 1){
                        mav.addObject("message1","新增失败！");
                    }
                });
            }
        }
        userOrder1.setSetTime(new Date());
        if(userOrderService.updateOrder(userOrder1) != 1) {
            mav.addObject("message","创建订单失败！");
        }
        mav.addObject("orderUser",userOrder1);
        return mav;
    }

    @RequestMapping("/forepayed")
    public ModelAndView forepayed(@RequestParam(value = "oid") int oid) {
        ModelAndView mav = new ModelAndView("paidPage");
        UserOrder userOrder = userOrderService.getById(oid);
        Date date = new Date();
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(date);
        calendar.add(calendar.DATE, 3);
        userOrder.setPayTime(new Date());
        userOrder.setSendTime(calendar.getTime());
        userOrder.setStatus(OrderStatusEnum.PAID.getFlag());
        if(userOrderService.updatePayTimeAndStatus(userOrder) != 1) {
            mav.addObject("message","支付失败！");
        }
        userOrder = userOrderService.getById(oid);
        List<Category> categoryList = categoryService.list();
        mav.addObject("userOrder",userOrder);
        mav.addObject("categoryList",categoryList);
        return mav;
    }

    @RequestMapping("forecategory")
    public ModelAndView forecategory(@RequestParam(value = "cid")int cid,@RequestParam(value = "sort",defaultValue = "综合")String sort) {
        ModelAndView mav = new ModelAndView("categoryDetail");
       /*
       * 增加数据后列表进行处理
       * */
       Category category = categoryService.getById(cid);
       List<Category> categoryList = categoryService.list();
       List<Category> categories = new LinkedList<>();
       int k = categoryList.size();
       int index = 0;
       index = categoryList.size() <= 4 ? k : 4;
       categories.addAll(categoryList.subList(0,index));
       List<ProductAndSellVo> productAndSellVoList = new ArrayList<>();
       /*
       * 获取产品列表
       * */
        List<Product> productList = null;
       /*
       * 获取综合排序数据
       * */
       if(SortMehodEnum.ALL.getDesc().equals(sort)) {
           productList = productService.list(cid);
       }
       /*
       * 根据新品排序
       * */
       else if (SortMehodEnum.DATE.getDesc().equals(sort)) {
           productList = productService.listByDate(cid);
       }
       /*
       * 根据价格进行排序
       * */
       else if (SortMehodEnum.PRICE.getDesc().equals(sort)) {
           productList = productService.listByPrice(cid);
       }
       else {
           productList = productService.list(cid);
       }
       productList.forEach(product -> {
           ProductAndSellVo productAndSellVo = new ProductAndSellVo();
           productAndSellVo.setProduct(product);
           Calendar c = Calendar.getInstance();
           c.set(c.get(Calendar.YEAR), c.get(Calendar.MONTH), c.getActualMaximum(Calendar.DAY_OF_MONTH), 23, 59, 59);
           SimpleDateFormat startSdf = new SimpleDateFormat("yyyy-MM-01  00:00:00");
           String format = startSdf.format(c.getTime());
           Date createTime = null;
           try {
               createTime = startSdf.parse(format);
           } catch (ParseException e) {
               e.printStackTrace();
           }
           List<Count> countList = countService.getByTime(createTime);
           /*
           * 获取月销售量
           * */
           if(countList == null) {
               productAndSellVo.setMonthSell(null);
           }
           else {
               int total = 0;
               for (Count count : countList) {
                   total = total + count.getNumber();
               }
               productAndSellVo.setMonthSell(total);
           }
           /*
           * 获取评论数
           * */
           List<Count> counts = countService.list();
           Set<Integer> set = new HashSet<>();
           counts.forEach(count -> set.add(count.getOid()));
           int message = 0;
           for (Integer s : set) {
               if (!StringUtils.isEmpty(userOrderService.getById(s).getUserMessage())) {
                   message++;
               }
           }
           productAndSellVo.setMessage(message);
           productAndSellVoList.add(productAndSellVo);
       });
       if (SortMehodEnum.REVIEW.getDesc().equals(sort)) {
           sortByReview(productAndSellVoList);
       }
       if (SortMehodEnum.SALECOUNT.getDesc().equals(sort)) {
           sortByCount(productAndSellVoList);
       }
       mav.addObject("category",category);
       mav.addObject("categoryList",categories);
       mav.addObject("productList",productAndSellVoList);
       return mav;
    }

    private void sortByCount(List<ProductAndSellVo> productAndSellVoList) {
        /*
        * 使用集合工具类进行排序
        * */
        Collections.sort(productAndSellVoList, new Comparator<ProductAndSellVo>() {
            @Override
            public int compare(ProductAndSellVo o1, ProductAndSellVo o2) {
                if(o1.getMonthSell() <= o2.getMonthSell()) {
                    return -1;
                }
                else {
                    return 1;
                }
            }
        });
    }


    private void sortByReview(List<ProductAndSellVo> productAndSellVoList) {
            /*
            * 使用集合工具类进行排序
            * */
            Collections.sort(productAndSellVoList, new Comparator<ProductAndSellVo>() {
                @Override
                public int compare(ProductAndSellVo o1, ProductAndSellVo o2) {
                    if(o1.getMessage() <= o2.getMessage()) {
                        return -1;
                    }else {
                        return 1;
                    }
                }
            });
    }

}
