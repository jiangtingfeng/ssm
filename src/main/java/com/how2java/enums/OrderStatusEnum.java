package com.how2java.enums;

import lombok.Getter;
import lombok.Setter;

public enum OrderStatusEnum {

    ORDER((Integer)1,"待付款"),
    PAID((Integer)2,"已付款"),
    SHIPPED((Integer)3,"代发货"),
    DELIVERED((Integer)4,"已发货"),
    CONFIRM((Integer)5,"确认收货");

    @Getter
    @Setter
    private Integer flag;

    @Getter
    @Setter
    private String desc;

    OrderStatusEnum(Integer flag,String desc){
        this.flag = flag;
        this.desc = desc;
    }

}
