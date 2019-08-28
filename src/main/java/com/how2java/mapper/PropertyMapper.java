package com.how2java.mapper;

import com.how2java.pojo.Property;
import com.how2java.util.Page;
import org.apache.ibatis.annotations.*;
import org.mybatis.spring.annotation.MapperScan;

import java.util.List;

@MapperScan
public interface PropertyMapper {

    @Insert("insert into property(propertyName,propertyValue,cid,updateUser,updateDate,categoryName) values(#{propertyName},#{propertyValue},#{cid},#{updateUser},#{updateDate},#{categoryName})")
    int insert(Property property);

    @Select("select *from property where id=#{id}")
    Property getById(int id);

    @Select("select *from property where cid=#{cid} order by id desc")
    List<Property> getByCid(int cid);

    @Select("select *from property where propertyName=#{propertyName}")
    Property getByName(String propertyName);

    @Select("select *from property where cid=#{cid} order by id desc limit #{start},#{count}")
    List<Property> getByCidAndPage(@Param(value = "cid") int cid, @Param(value = "start") int start, @Param(value = "count") int count);

    @Select("select count(*) from property")
    int count();

    @Delete("delete from property where id=#{id}")
    int delete(int id);

    @Delete("delete from property where cid=#{cid}")
    int deleteByCid(int cid);

    @Update("update property set propertyName=#{propertyName},propertyValue=#{propertyValue} where id=#{id}")
    int update(Property property);
}
