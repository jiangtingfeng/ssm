package com.how2java.pojo;

import lombok.Data;

import java.util.Date;

@Data
public class UserOrder {
    private Integer id;
    private Integer status;
    private float totalMoney;
    private Integer productNumber;
    private String buyerName;
    private Date setTime;
    private Date payTime;
    private Date sendTime;
    private Date confirmTime;
    private String address;
    private Integer post;
    private String mobile;
    private String userMessage;
    private int uid;
    private String receiver;
    private String orderNumber;
}
