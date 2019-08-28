package com.how2java.service;

import com.how2java.mapper.ProductPicMapper;
import com.how2java.pojo.ProductPic;
import com.how2java.pojo.User;
import com.how2java.util.UserConstans;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class ProductPicService {

    @Autowired
    ProductPicMapper productPicMapper;

    public int  insert(ProductPic productPic) {
        UserConstans userConstans = new UserConstans();
        User user = userConstans.getUser();
        productPic.setUpdateUser(user.getName());
        productPic.setUpdateTime(new Date());
        return productPicMapper.insert(productPic);
    }

    public int deleteById(int id) {
        return productPicMapper.deleteById(id);
    }

    public List<ProductPic> getByPid(int pid) {
        return productPicMapper.getByPid(pid);
    }


    public ProductPic getById(int id) {
        return productPicMapper.getById(id);
    }
}
