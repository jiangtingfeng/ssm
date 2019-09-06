package com.how2java.mapper;

import com.how2java.pojo.Comment;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.mybatis.spring.annotation.MapperScan;

import java.util.List;

@MapperScan
public interface CommentMapper {

    @Insert("insert into comment(message,userName,updateDate,pid) values(#{message},#{userName},#{updateDate},#{pid})")
    int insert (Comment comment);

    @Select("select *from comment where pid=#{pid} order by updateDate desc")
    List<Comment> listByPid(Integer pid);


    @Delete("delete from comment where pid=#{pid}")
    int delete(Integer pid);
}
