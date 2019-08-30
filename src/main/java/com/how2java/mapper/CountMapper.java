package com.how2java.mapper;

import com.how2java.pojo.Count;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RestController;

import java.util.Date;
import java.util.List;

@MapperScan
public interface CountMapper {

    @Select("select *from count order by id desc")
    List<Count> list();

    @Select("select *from count where oid=#{oid} ")
    List<Count> getByOid(int oid);

    @Insert("insert into count values(#{id},#{pid},#{number},#{oid},#{createTime},#{uid})")
    int insert(Count count);

    @Select("select *from count where id=#{id}")
    Count getById(int id);

    @Update("update count set number=#{number} where id=#{id}")
    int update(Count count);

    @Select("select *from count where date_format(createTime,'%Y-%m')=date_format(now(),'%Y-%m')")
    List<Count> getByTime();

    @Select("select *from count where pid=#{pid}")
    List<Count> getByPid(int pid);
}
