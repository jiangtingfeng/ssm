package com.how2java.pojo;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.util.Date;

@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class Count {
    private Integer id;
    private Integer pid;
    private Integer number;
    private Integer oid;
    private Date createTime;
    private Integer uid;
    private Integer status;
}
