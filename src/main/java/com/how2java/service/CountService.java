package com.how2java.service;

import com.how2java.mapper.CountMapper;
import com.how2java.pojo.Count;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.LinkedList;
import java.util.List;

@Service
public class CountService {

    @Autowired
    private CountMapper countMapper;

    public List<Count> getByOid(int oid) {
        if(countMapper.getByOid(oid) != null) {
            return countMapper.getByOid(oid);
        }
        return null;
    }

    public List<Count> list() {
        return countMapper.list();
    }

    public int insert(Count count) {
        return countMapper.insert(count);
    }

    public Count getById(int id) {
        return countMapper.getById(id);
    }

    public int update(Count count) {
        return countMapper.update(count);
    }

    public int updateStatus(Count count) {
        return countMapper.updateStatus(count);
    }

    public List<Count> getByTime(Date createTime){
        return countMapper.getByTime();
    }

    public List<Count> getByPid(int pid) {
        return countMapper.getByPid(pid);
    }

    public List<Count> getByOidAndStatus(Integer id, int status) {
        if(countMapper.getByOidAndStatus(id,status) == null) {
            return null;
        }
        return countMapper.getByOidAndStatus(id,status);
    }
    public int delete(Integer id) {
        return countMapper.delete(id);
    }
}
