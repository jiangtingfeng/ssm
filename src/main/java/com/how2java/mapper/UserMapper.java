package com.how2java.mapper;

import com.how2java.pojo.User;
import org.apache.ibatis.annotations.*;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Service;

import java.util.List;

@MapperScan
public interface UserMapper  {

    @Select("select *from user where name=#{name}")
    User getByName(String name);

    @Select("select *from user where phoneNumber=#{phoneNumber}")
    User getByPhoneNumber(String phoneNumber);

    @Insert("insert into user(name,password,phoneNumber,createTime) values(#{name},#{password},#{phoneNumber},#{createTime})")
    int insert(User user);

    @Select("select *from user where name=#{name} and password=#{password}")
    User getByUser(User user);

    @Select("select *from user where name=#{name} and phoneNumber=#{phoneNumber}")
    User getByNameAndPhone(@Param("name") String name,
                                @Param("phoneNumber") String phoneNumber);

    @Update("update user set password=#{password} where name=#{name}")
    int updateByName(@Param("password") String password,@Param("name") String name);

    @Select("select *from user order by id desc")
    List<User> list();

    @Delete("delete from user where id=#{id}")
    int delete(int id);
}
