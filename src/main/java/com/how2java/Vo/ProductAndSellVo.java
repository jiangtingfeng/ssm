package com.how2java.Vo;

import com.how2java.pojo.Product;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class ProductAndSellVo {
    private Product product;
    private Integer monthSell;
    private Integer message;
}
