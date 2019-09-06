package com.how2java.mapper;

import com.how2java.pojo.User;
import com.how2java.pojo.UserOrder;
import org.apache.ibatis.annotations.*;
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

    @Insert("insert into userOrder(status,totalMoney,productNumber,buyerName,setTime,payTime,sendTime,confirmTime,address,post,mobile,userMessage,uid,receiver,orderNumber)" +
            "values(#{status},#{totalMoney},#{productNumber},#{buyerName},#{setTime},#{payTime},#{sendTime},#{confirmTime},#{address},#{post},#{mobile},#{userMessage},#{uid},#{receiver},#{orderNumber})")
    int insert(UserOrder order);

    @Update("update userOrder set sendTime=#{sendTime},status=#{status} where id=#{id}")
        int update(UserOrder order);

    @Update("update userOrder set productNumber=#{productNumber},status=#{status},totalMoney=#{totalMoney} where id=#{id}")
    int updateNumber(UserOrder order);

    @Update("update userOrder set address=#{address},post=#{post},mobile=#{mobile},userMessage=#{userMessage},receiver=#{receiver},orderNumber=#{orderNumber} where id=#{id}")
    int updateOrder(UserOrder userOrder);

    @Update("update userOrder set status=#{status},payTime=#{payTime},sendTime=#{sendTime} where id=#{id}")
    int updatePayTimeAndStatus(UserOrder userOrder);

    @Update("update userOrder set status=#{status},confirmTime=#{confirmTime} where id=#{id}")
    int updateStatus(UserOrder userOrder);

    @Update("update userOrder set status=#{status},sendTime=#{sendTime} where id=#{id}")
    int updateStatus1(UserOrder userOrder);

    @Delete("delete from userOrder where id = #{id}")
    int delete(@Param(value = "id") int id);
}