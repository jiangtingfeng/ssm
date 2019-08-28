package com.how2java.mapper;

import com.how2java.pojo.UserOrder;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.mybatis.spring.annotation.MapperScan;

import java.util.List;

@MapperScan
public interface UserOrderMapper {

    @Select("select *from userOrder where id=#{id}")
    UserOrder getById(int id);

    @Select("select *from userOrder order by id desc")
    List<UserOrder> list();

    @Select("select *from userOrder where buyerName=#{buyerName}")
    UserOrder getByBuyerName(String name);

    @Insert("insert into userOrder(status,totalMoney,productNumber,buyerName,setTime,payTime,sendTime,confirmTime,address,post,mobile,userMessage,uid) values(#{status},#{totalMoney},#{productNumber},#{buyerName},#{setTime},#{payTime},#{sendTime},#{confirmTime},#{address},#{post},#{mobile},#{userMessage},#{uid})")
    int insert(UserOrder order);

    @Update("update userOrder set sendTime=#{sendTime},status=#{status} where id=#{id}")
        int update(UserOrder order);
}