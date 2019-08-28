package com.how2java.mapper;

import com.how2java.pojo.Count;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.mybatis.spring.annotation.MapperScan;

import java.util.List;

@MapperScan
public interface CountMapper {

    @Select("select *from count order by id desc")
    List<Count> list();

    @Select("select *from count where oid=#{oid}")
    List<Count> getByOid(int oid);

    @Insert("insert into count(pid,number,oid) values(#{pid},#{number},#{oid})")
    int insert(Count count);

    @Select("select *from count where id=#{id}")
    Count getById(int id);
}
