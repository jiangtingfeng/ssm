package com.how2java.service;

import com.how2java.mapper.ProductMapper;
import com.how2java.pojo.Product;
import com.how2java.pojo.User;
import com.how2java.util.Page;
import com.how2java.util.UserConstans;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class ProductService {

    @Autowired
    ProductMapper productMapper;

    public List<Product> list(int cid) {
        return productMapper.list(cid);
    }
    public List<Product> list(int cid, Page page) {
        return productMapper.getByCidAndPage(cid,page.getStart(),page.getCount());
    }

    public void add(Product product) {
        boolean result = true;
        UserConstans userConstans = new UserConstans();
        User user = userConstans.getUser();
        product.setUpdateDate(new Date());
        product.setUpdateUser(user.getName());
        productMapper.add(product);
    }
    public Product getByProductName(String name){
        return productMapper.getByName(name);
    }
    public int count(){
        return productMapper.count();
    }
    public Product getById(int id){
        return productMapper.get(id);
    }
    public int deleteByCid(int cid){
        return productMapper.deleteByCid(cid);
    }

    public int update(Product product) {
        return productMapper.update(product);
    }

    public int deleteById(int id) {
        return productMapper.delete(id);
    }

    public List<Product> listByDate(int cid) {
        return productMapper.listByDate(cid);
    }

    public List<Product> listByPrice(int cid) {
        return productMapper.listByPrice(cid);
    }
}
