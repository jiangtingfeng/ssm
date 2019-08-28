package com.how2java.Vo;

import com.how2java.pojo.Product;
import com.how2java.util.Page;
import lombok.Data;

@Data
public class ProductAndNumber extends Product {
    private Integer numberOfBuy;
}
