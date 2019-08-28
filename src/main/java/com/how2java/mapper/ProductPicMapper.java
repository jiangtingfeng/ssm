package com.how2java.mapper;

import com.how2java.pojo.ProductPic;
import lombok.Data;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Service;

import java.util.List;

@MapperScan
public interface ProductPicMapper {

    @Insert("insert into productPic(productPic,pid,updateTime,updateUser) values(#{productPic},#{pid},#{updateTime},#{updateUser})")
     int insert(ProductPic productPic);

    @Select("select *from productPic where pid=#{pid} order by id desc")
    List<ProductPic> getByPid(int pid);

    @Update("update productPic set productPic=#{productPic} where id=#{id}")
    int update(ProductPic productPic);

    @Delete("delete from productPic where id=#{id}")
    int deleteById(int id);

    @Select("select *from productPic where id=#{id}")
    ProductPic getById(int id);
}
