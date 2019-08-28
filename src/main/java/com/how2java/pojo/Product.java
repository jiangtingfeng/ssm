package com.how2java.pojo;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import org.springframework.stereotype.Component;

import java.util.Date;


@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class Product {
    private int id;
    private String productPic;
    private String productName;
    private String productTitle;
    private float price;
    private float lowerPrice;
    private Integer number;
    private Integer cid;
    private String categoryName;
    private String updateUser;
    private Date updateDate;
}
