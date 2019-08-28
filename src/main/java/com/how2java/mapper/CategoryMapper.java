package com.how2java.mapper;
 
import java.util.List;

import com.how2java.pojo.Category;
import com.how2java.util.Page;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.mybatis.spring.annotation.MapperScan;

@MapperScan
public interface CategoryMapper {
    @Insert("insert into category(categoryName,categoryPic,updateUser,updateDate) values(#{categoryName},#{categoryPic},#{updateUser},#{updateDate})")
    int addCategory(Category category);

    @Delete("delete from category where id=#{id}")
    int delete(int id);

    @Select("select *from category where categoryName=#{categoryName}")
    Category getByName(String categoryName);

    @Update("update category set categoryName=#{categoryName},categoryPic=#{categoryPic} where id=#{id}")
    int update(Category category);
    //弃用
    @Select("select *from category order by id desc limit #{start},#{count}")
    List<Category> listCategory(Page page);

    @Select("select *from category order by id desc")
    List<Category> listCategory1();

    @Select("select count(*) from category")
    int count();

    @Select("select *from category where id=#{id}")
    Category getById(int id);
}