package com.how2java.pojo;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.util.Date;

@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class Property {
    private int id;
    private String propertyName;
    private String propertyValue;
    private int cid;
    private String categoryName;
    private String updateUser;
    private Date updateDate;
}
