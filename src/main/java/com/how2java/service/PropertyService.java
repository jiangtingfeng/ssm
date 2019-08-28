package com.how2java.service;

import com.how2java.mapper.PropertyMapper;
import com.how2java.pojo.Property;
import com.how2java.pojo.User;
import com.how2java.util.Page;
import com.how2java.util.UserConstans;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.xml.crypto.Data;
import java.util.Date;
import java.util.List;

@Service
public class PropertyService {

    @Autowired
    private PropertyMapper propertyMapper;


    public List<Property> getByCidAndPage(int cid, Page page){
        return propertyMapper.getByCidAndPage(cid,page.getStart(),page.getCount());
    }
    public void addProperty(Property property){
        UserConstans userConstans = new UserConstans();
        User user = userConstans.getUser();
        property.setUpdateDate(new Date());
        property.setUpdateUser(user.getName());
        propertyMapper.insert(property);
    }

    public Property getByName(String name){
        return propertyMapper.getByName(name);
    }

    public int count(){
        return propertyMapper.count();
    }

    public List<Property> getByCid(int cid){
        return propertyMapper.getByCid(cid);
    }
    public int deleteById(int id) {
        return propertyMapper.delete(id);
    }

    public int deleteByCid(int cid){
        return propertyMapper.deleteByCid(cid);
    }

    public Property getById(int id) {
        return propertyMapper.getById(id);
    }

    public int updateById(Property property){
        return propertyMapper.update(property);
    }
}
