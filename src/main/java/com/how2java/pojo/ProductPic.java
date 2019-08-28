package com.how2java.pojo;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.util.Date;

@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class ProductPic {
    private int id;
    private String productPic;
    private int pid;
    private Date updateTime;
    private String updateUser;
}
