package com.how2java.service;

import com.how2java.mapper.UserMapper;
import com.how2java.pojo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {

    @Autowired
    UserMapper userMapper;

    public User getByUser(User user){
        return userMapper.getByUser(user);
    }

    public User getByName(String name){
        return userMapper.getByName(name);
    }

    public User getByPboneNumber(String phoneNumber) {
        return userMapper.getByPhoneNumber(phoneNumber);
    }

    public int insert(User user) {
        return userMapper.insert(user);
    }

    public boolean getByNameAndPhone(String name,String phoneNumber){
        boolean result = true;
       User byNameAndPhone = userMapper.getByNameAndPhone(name, phoneNumber);
        if(byNameAndPhone == null){
            result = false;
        }
        return result;
    }

    public int updateByName(String password,String name){
        return userMapper.updateByName(password,name);
    }

    public List<User> list() {
        return userMapper.list();
    }

    public int deleteById(int id) {
        return userMapper.delete(id);
    }
}
