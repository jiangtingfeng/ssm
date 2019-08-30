package com.how2java.mapper;

import com.how2java.SqlProvider.ProductDynaSqlProvider;

import com.how2java.pojo.Product;
import com.how2java.pojo.Property;
import org.apache.ibatis.annotations.*;
import org.mybatis.spring.annotation.MapperScan;


import java.util.List;

@MapperScan
public interface ProductMapper {
    @Insert("insert into product (productName,productTitle,price,lowerPrice,number,cid,updateUser,updateDate,productPic,categoryName) " +
            "values(#{productName},#{productTitle},#{price},#{lowerPrice},#{number},#{cid},#{updateUser},#{updateDate},#{productPic},#{categoryName})")
      int add(Product product);

    @Delete("delete from product where id=#{id}")
      int delete(int id);

    @Delete("delete from product where cid=#{cid}")
    int deleteByCid(int cid);

    @Select("select *from product where cid=#{cid} order by id desc")
    List<Product> list(int cid);

    @Select("select *from product where cid=#{cid} order by updateDate desc")
    List<Product> listByDate(int cid);

    @Select("select *from product where cid=#{cid} order by price desc")
    List<Product> listByPrice(int cid);


    @Select("select *from product where cid=#{cid} order by id desc limit #{start},#{count}")
    List<Product> getByCidAndPage(@Param(value = "cid") int cid, @Param(value = "start") int start, @Param(value = "count") int count);


    @Update("update product set productName=#{productName},productTitle=#{productTitle},price=#{price},lowerPrice=#{lowerPrice},number=#{number} where id=#{id}")
      int update(Product product);

    @Select("select *from product where id=#{id}")
      Product get(int id);

    @Select("select *from product where productName=#{productName}")
    Product getByName(String productName);

    @Select("select count(*) from product")
    int count();


}
