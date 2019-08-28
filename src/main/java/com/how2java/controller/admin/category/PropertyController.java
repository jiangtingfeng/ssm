package com.how2java.controller.admin.category;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.how2java.pojo.Product;
import com.how2java.pojo.Property;
import com.how2java.service.PropertyService;
import com.how2java.util.Page;
import org.junit.Assert;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class PropertyController {

    @Autowired
    PropertyService propertyService;

    @RequestMapping("/property_edit")
    public ModelAndView propertyEdit(@RequestParam(value = "id")int id){
         ModelAndView mav = new ModelAndView("propertyEdit");
        Property property = propertyService.getById(id);
        mav.addObject("property",property);
        return mav;
    }

    @RequestMapping("/admin_property_update")
    public ModelAndView propertyUpdate(Property property){
        ModelAndView mav = new ModelAndView("propertyEdit");
        if(propertyService.getByName(property.getPropertyName()) != null) {
            mav.addObject("message","该属性名已存在，请重新赋值！");
        }
        else
            if(propertyService.updateById(property) != 0) {
            mav.addObject("message","编辑成功！");
            }
        Property property1 = propertyService.getById(property.getId());
        mav.addObject("property",property1);
        return mav;
    }

    @RequestMapping("/property_delete")
    public ModelAndView propertyDelete(@RequestParam(value = "id")int id){
        ModelAndView mav = new ModelAndView("property");
        Property property = propertyService.getById(id);
        if(propertyService.deleteById(id) != 0) {
            mav.addObject("message1","删除成功！");
        }
        List<Property> properties = propertyService.getByCid(property.getCid());
        PageHelper.startPage(1,Page.COUNT);
        PageInfo<Property> propertyPageInfo = new PageInfo<>(properties,Page.COUNT);
        mav.addObject("list",propertyPageInfo);
        mav.addObject("categoryName",property.getCategoryName());
        mav.addObject("cid",property.getCid());
        return mav;
    }


}
