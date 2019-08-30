package com.how2java.service;

import com.how2java.mapper.UserOrderMapper;
import com.how2java.pojo.UserOrder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserOrderService {

    @Autowired
    private UserOrderMapper orderMapper;

    public UserOrder getByBuyerName(String name) {
        return orderMapper.getByBuyerName(name);
    }

    public UserOrder getById(int id){
        return orderMapper.getById(id);
    }

    public List<UserOrder> list() {
        return orderMapper.list();
    }

    public int insert(UserOrder order) {
        return orderMapper.insert(order);
    }

    public int update(UserOrder userOrder) {
        return orderMapper.update(userOrder);
    }
    public int updateNumber(UserOrder order) {
        return orderMapper.updateNumber(order);
    }
    public int updateOrder(UserOrder userOrder){
        return orderMapper.updateOrder(userOrder);
    }
    public int updatePayTimeAndStatus(UserOrder userOrder){
        return orderMapper.updatePayTimeAndStatus(userOrder);
    }
}
