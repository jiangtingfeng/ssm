package com.how2java.pojo;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.util.Date;

@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class Comment {
    private Integer id;
    private String message;
    private String userName;
    private Date updateDate;
    private Integer pid;
}
