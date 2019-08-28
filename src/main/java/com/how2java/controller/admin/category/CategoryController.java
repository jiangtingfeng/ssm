package com.how2java.controller.admin.category;


import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import com.how2java.pojo.Product;
import com.how2java.pojo.Property;
import com.how2java.service.CategoryService;
import com.how2java.service.ProductService;
import com.how2java.service.PropertyService;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.how2java.pojo.Category;
import com.how2java.util.Page;

import javax.jws.WebParam;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// 告诉spring mvc这是一个控制器类
@Controller
public class CategoryController {

	@Autowired
	CategoryService categoryService;

	@Autowired
	PropertyService propertyService;

	@Autowired
	ProductService productService;


	@RequestMapping("/admin_category_list")
    public ModelAndView adminCategoryList(@RequestParam(value = "start",defaultValue = "1")int start){
        ModelAndView mav = new ModelAndView("category");
	    Page page = new Page();
	    PageHelper.startPage(start,Page.COUNT);
	    List<Category> categoryList = categoryService.list();
	    PageInfo<Category> pageInfo = new PageInfo<Category>(categoryList,Page.COUNT);
	    mav.addObject("list",pageInfo);
	    return mav;
    }

	@RequestMapping("/categoryList")
	public ModelAndView showCategory(@RequestParam(value = "start",defaultValue = "1")int start){
		ModelAndView mav = new ModelAndView("category");
		List<Category> cs = categoryService.list();
		int total = categoryService.count();
        PageHelper.startPage(1,Page.COUNT);
        PageInfo<Category> categoryPageInfo = new PageInfo<>(cs,Page.COUNT);
		mav.addObject("list",categoryPageInfo);
		return mav;
	}

	@RequestMapping("/propertyList")
    public ModelAndView showProperty(@RequestParam(value = "start",defaultValue = "1")int start,int cid){
        ModelAndView mav = new ModelAndView("property");
        Category category = categoryService.getById(cid);
        List<Property> ps = propertyService.getByCid(cid);
        PageHelper.startPage(start,Page.COUNT);
        PageInfo<Property> propertyPageInfo = new PageInfo<>(ps,Page.COUNT);
        mav.addObject("list",propertyPageInfo);
		mav.addObject("categoryName",category.getCategoryName());
        return mav;
    }

	@RequestMapping(value = "/addCategory",method = RequestMethod.POST)
	public ModelAndView addCategory(@RequestParam(value = "start",defaultValue = "1")int start,Category category, @RequestParam(value = "file",required = false) MultipartFile file, HttpServletRequest request) throws IOException {
		/**
		 * 上传图片
		 */
		String name = RandomStringUtils.randomAlphanumeric(10);
		String newFileName = name + ".jpg";
		File newFile = new File(request.getServletContext().getRealPath("/image"), newFileName);
		newFile.getParentFile().mkdirs();
		file.transferTo(newFile);
		category.setCategoryPic(newFileName);
		ModelAndView modelAndView = new ModelAndView("category");
		if(categoryService.getByName(category.getCategoryName()) != null){
			modelAndView.addObject("message","该产品分类已存在！");
		}else {
			modelAndView.addObject("message","类别添加成功！");
			categoryService.addCategory(category);
		}
        List<Category> cs = categoryService.list();
		PageHelper.startPage(start,Page.COUNT);
		PageInfo<Category> categoryPageInfo = new PageInfo<>(cs,Page.COUNT);
        modelAndView.addObject("list",categoryPageInfo);
		return modelAndView;
	}
    @RequestMapping(value = "/category_edit")
    public ModelAndView categeryEdit(@RequestParam(value = "id")int id){
	    Category category = categoryService.getById(id);
	    ModelAndView mav = new ModelAndView("categoryEdit");
	    mav.addObject("category",category);
	    return mav;
    }
    @RequestMapping("/admin_category_update")
    public ModelAndView editCategory(Category category, @RequestParam(value = "file",required = false) MultipartFile file, HttpServletRequest request) throws IOException {
        String name = RandomStringUtils.randomAlphanumeric(10);
        String newFileName = name + ".jpg";
        File newFile = new File(request.getServletContext().getRealPath("/image"), newFileName);
        newFile.getParentFile().mkdirs();
        file.transferTo(newFile);
        category.setCategoryPic(newFileName);
        ModelAndView modelAndView = new ModelAndView("categoryEdit");
        if(categoryService.getByName(category.getCategoryName()) != null){
            modelAndView.addObject("message","该产品分类已存在！请重新更改产品名");
        }else {
            if(categoryService.update(category) != 0){
                modelAndView.addObject("message","类别修改成功！");
            }
        }
        return modelAndView;
    }
    @RequestMapping("/category_delete")
    public ModelAndView deleteCategory(@RequestParam(value = "id")int id){
	    ModelAndView modelAndView = new ModelAndView("category");
	    if(categoryService.deleteCategory(id)){
             modelAndView.addObject("message1","删除成功");
        }
        List<Category> cs = categoryService.list();
        PageHelper.startPage(1,Page.COUNT);
        PageInfo<Category> categoryPageInfo = new PageInfo<>(cs,Page.COUNT);
        modelAndView.addObject("list",categoryPageInfo);
	    return modelAndView;
    }
	@ResponseBody
	@RequestMapping(value = "/category_property_list")
	public ModelAndView category(@RequestParam(value = "cid")int cid, HttpServletRequest request, HttpServletResponse response,@RequestParam(value = "start",defaultValue = "1")int start) {
		ModelAndView modelAndView = new ModelAndView("property");
		Category category = categoryService.getById(cid);
		List<Property> properties = propertyService.getByCid(cid);
		PageHelper.startPage(start,Page.COUNT);
		PageInfo<Property> pageInfo = new PageInfo<>(properties,Page.COUNT);
		modelAndView.addObject("list",pageInfo);
		modelAndView.addObject("categoryName",category.getCategoryName());
		modelAndView.addObject("cid",cid);
		return modelAndView;
	}

	@RequestMapping(value = "/addProperty")
    public ModelAndView addProperty(Property property,@RequestParam(value = "start",defaultValue = "1")int start,@RequestParam(value = "cid")int cid) {
        ModelAndView mav = new ModelAndView("property");
        Category category = categoryService.getById(property.getCid());
	     if(propertyService.getByName(property.getPropertyName()) != null) {
	     	 mav.addObject("message","属性名已存在!");
         }
	     else {
	         propertyService.addProperty(property);
	         mav.addObject("message","添加成功");
         }
	     List<Property> properties = propertyService.getByCid(property.getCid());
	     PageHelper.startPage(start,Page.COUNT);
	     PageInfo<Property> propertyPageInfo = new PageInfo<>(properties,Page.COUNT);
	     mav.addObject("list",propertyPageInfo);
	     mav.addObject("categoryName",category.getCategoryName());
         mav.addObject("cid",property.getCid());
	     return mav;
    }


    @ResponseBody
	@RequestMapping(value = "/category_product_list",method = RequestMethod.GET)
	public ModelAndView categoryProductList(@RequestParam(value = "cid")int cid,HttpServletRequest request, HttpServletResponse response,@RequestParam(value = "start",defaultValue = "1")int start) {
		ModelAndView mav = new ModelAndView("categoryProductList");
		Category category = categoryService.getById(cid);
		List<Product> products = productService.list(cid);
		PageHelper.startPage(start,Page.COUNT);
		PageInfo<Product> productPageInfo = new PageInfo<>(products,Page.COUNT);
		mav.addObject("list",productPageInfo);
		mav.addObject("categoryName",category.getCategoryName());
		mav.addObject("cid",cid);
		return mav;
	}

    @RequestMapping(value = "/admin_product_add")
    public ModelAndView adminProductAdd(@RequestParam(value = "cid")int cid, Product product, @RequestParam(value = "file",required = false) MultipartFile file, HttpServletRequest request,@RequestParam(value = "start",defaultValue = "1")int start) throws IOException {
        /**
         * 上传图片
         */
        Category category =  categoryService.getById(product.getCid());
        String name = RandomStringUtils.randomAlphanumeric(10);
        String newFileName = name + ".jpg";
        File newFile = new File(request.getServletContext().getRealPath("/image"), newFileName);
        newFile.getParentFile().mkdirs();
        file.transferTo(newFile);
        product.setProductPic(newFileName);
        ModelAndView modelAndView = new ModelAndView("categoryProductList");
        if(productService.getByProductName(product.getProductName()) != null){
            modelAndView.addObject("message","该产品名已存在！");
        }else {
            modelAndView.addObject("message","类别产品成功！");
            productService.add(product);
        }
        List<Product> products = productService.list(product.getCid());
        PageHelper.startPage(start,Page.COUNT);
        PageInfo<Product> productPageInfo = new PageInfo<>(products,Page.COUNT);
        modelAndView.addObject("list",productPageInfo);
        modelAndView.addObject("categoryName",category.getCategoryName());
        modelAndView.addObject("cid",product.getCid());
        return modelAndView;
    }
}
