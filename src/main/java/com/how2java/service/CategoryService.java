package com.how2java.service;

import java.util.Date;
import java.util.List;

import com.how2java.pojo.User;
import com.how2java.util.Page;
import com.how2java.util.UserConstans;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.how2java.mapper.CategoryMapper;
import com.how2java.pojo.Category;

@Service
public class CategoryService {
	@Autowired
	CategoryMapper categoryMapper;

	@Autowired
	ProductService productService;

	@Autowired
	PropertyService propertyService;

	public List<Category> list() {
		return categoryMapper.listCategory1();
	}

	public List<Category> list(Page page) {
		return categoryMapper.listCategory(page);
	}

	public int count() {
		return categoryMapper.count();
	}

	public int addCategory(Category category) {
		UserConstans userConstans = new UserConstans();
		User user = userConstans.getUser();
		category.setUpdateDate(new Date());
		category.setUpdateUser(user.getName());
		return categoryMapper.addCategory(category);
	}

	public boolean deleteCategory(int id){
		if(productService.deleteByCid(id)>=0 && propertyService.deleteByCid(id) >= 0 && categoryMapper.delete(id)!=0){
			return true;
		}
		return false;
    }
	public Category getByName(String name){
		return categoryMapper.getByName(name);
	}

	public Category getById(int id){
		return categoryMapper.getById(id);
	}

	public int update(Category category){
	    return categoryMapper.update(category);
    }
}
