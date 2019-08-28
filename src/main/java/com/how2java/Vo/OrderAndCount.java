package com.how2java.Vo;

import com.how2java.pojo.UserOrder;
import lombok.Data;

import java.util.List;

@Data
public class OrderAndCount {
    private UserOrder order;
    private List<ProductAndNumber> productAndNumbers;
}
