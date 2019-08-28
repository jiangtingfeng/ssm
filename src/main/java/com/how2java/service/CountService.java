package com.how2java.service;

import com.how2java.mapper.CountMapper;
import com.how2java.pojo.Count;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CountService {

    @Autowired
    private CountMapper countMapper;

    public List<Count> getByOid(int oid) {
        return countMapper.getByOid(oid);
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
}
