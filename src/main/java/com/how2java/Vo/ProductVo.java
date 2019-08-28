package com.how2java.Vo;

import com.how2java.pojo.Category;
import com.how2java.pojo.Product;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class ProductVo {
    Category category;
    List<Product> products;
}
