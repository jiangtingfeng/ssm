package com.how2java.service;

import com.how2java.mapper.CommentMapper;
import com.how2java.pojo.Comment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentService {

    @Autowired
    private CommentMapper commentMapper;

    public int insert(Comment comment) {
        return commentMapper.insert(comment);
    }

    public int delete(Integer pid) {
        return commentMapper.delete(pid);
    }

    public List<Comment> list(Integer pid) {
        return commentMapper.listByPid(pid);
    }
}
