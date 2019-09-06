package com.how2java.controller.admin.category;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.how2java.pojo.Category;
import com.how2java.pojo.Product;
import com.how2java.pojo.ProductPic;
import com.how2java.pojo.Property;
import com.how2java.service.ProductPicService;
import com.how2java.service.ProductService;
import com.how2java.service.PropertyService;
import com.how2java.util.Page;
import org.apache.commons.lang.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.List;

@Controller
public class ProductController {
    @Autowired
    private ProductService productService;
    @Autowired
    private ProductPicService productPicService;
    @Autowired
    private PropertyService propertyService;

    @RequestMapping("/admin_productImage_list")
    public ModelAndView productImageList(@RequestParam(value = "pid") int pid){
        ModelAndView modelAndView = new ModelAndView("productImage");
        //获取详情图片列表
        List<ProductPic> productPics = productPicService.getByPid(pid);
        modelAndView.addObject("listProductPics",productPics);
        //获取产品图片
        Product product = productService.getById(pid);
        modelAndView.addObject("product",product);
        return modelAndView;
    }

    @RequestMapping("/admin_productImage_add")
    public ModelAndView productImageAdd(ProductPic productPic, @RequestParam(value = "file",required = false) MultipartFile file, HttpServletRequest request) throws IOException {
        ModelAndView modelAndView = new ModelAndView("productImage");
        /**
         * 上传图片
         */
        String name = RandomStringUtils.randomAlphanumeric(10);
        String newFileName = name + ".jpg";
        File newFile = new File(request.getServletContext().getRealPath("/image"), newFileName);
        newFile.getParentFile().mkdirs();
        if(file != null){
            file.transferTo(newFile);
        }
        productPic.setProductPic(newFileName);
        if(productPicService.insert(productPic) != 0) {
            modelAndView.addObject("message","添加成功！");
        }
        List<ProductPic> productPics = productPicService.getByPid(productPic.getPid());
        modelAndView.addObject("listProductPics",productPics);
        Product product = productService.getById(productPic.getPid());
        modelAndView.addObject("product",product);
        return modelAndView;
    }

    @RequestMapping("/admin_productImage_delete")
    public ModelAndView productImageDelete(@RequestParam(value = "id")int id){
        ModelAndView modelAndView = new ModelAndView("productImage");
        ProductPic productPic = productPicService.getById(id);
        if(productPicService.deleteById(id) != 0) {
            modelAndView.addObject("message1","删除成功！");
        }
        if(productPic != null) {
            List<ProductPic> productPics = productPicService.getByPid(productPic.getPid());
            modelAndView.addObject("listProductPics",productPics);
            Product product = productService.getById(productPic.getPid());
            modelAndView.addObject("product",product);
        }
        return modelAndView;
    }


    @RequestMapping("/admin_propertyValue_edit")
    public ModelAndView propertyValueEdit(@RequestParam(value = "pid")int pid) {
        ModelAndView modelAndView = new ModelAndView("productPropertyValue");
        Product product = productService.getById(pid);
        List<Property> properties = propertyService.getByCid(product.getCid());
        modelAndView.addObject("properties",properties);
        modelAndView.addObject("product",product);
        return modelAndView;
    }

    @RequestMapping("/editPropertyValue")
    public ModelAndView editPropertyValue(Property property,int pid) {
        ModelAndView modelAndView = new ModelAndView("productPropertyValue");
        if(propertyService.updateById(property) != 0) {
                modelAndView.addObject("message","编辑成功！");
        }
        Product product = productService.getById(pid);
        List<Property> properties = propertyService.getByCid(property.getCid());
        modelAndView.addObject("properties",properties);
        modelAndView.addObject("product",product);
        return modelAndView;
    }
    @RequestMapping("/admin_product_edit")
    public ModelAndView produceEdit(@RequestParam(value = "id") int id){
        ModelAndView modelAndView = new ModelAndView("productEdit");
        Product product = productService.getById(id);
        modelAndView.addObject("product",product);
        return modelAndView;
    }

    @RequestMapping("/admin_product_update")
    public ModelAndView productUpdate(Product product) {
        ModelAndView modelAndView = new ModelAndView("productEdit");
        if(productService.getByProductName(product.getProductName()) != null) {
            modelAndView.addObject("message","产品名已存在，请重新命名！");
        }else {
            if(productService.update(product) != 0) {
                modelAndView.addObject("message","修改成功！");
            }
        }
        Product product1 = productService.getById(product.getId());
        modelAndView.addObject("product",product1);
        return modelAndView;
    }

    @RequestMapping("/admin_product_delete")
    public ModelAndView productDelete(@RequestParam(value = "start",defaultValue = "1")int start,@RequestParam(value = "id")int id) {
        ModelAndView modelAndView = new ModelAndView("categoryProductList");
        Product product = productService.getById(id);
        if(productService.deleteById(id) != 0){
            modelAndView.addObject("message","删除成功！");
        }
        List<Product> products = productService.list(product.getCid());
        PageHelper.startPage(start, Page.COUNT);
        PageInfo<Product> productPageInfo = new PageInfo<>(products,Page.COUNT);
        modelAndView.addObject("list",productPageInfo);
        modelAndView.addObject("categoryName",product.getCategoryName());
        modelAndView.addObject("cid",product.getCid());
        return modelAndView;
    }
}
