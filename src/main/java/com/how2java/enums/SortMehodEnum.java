package com.how2java.enums;

import lombok.Getter;
import lombok.Setter;

public enum SortMehodEnum {

    ALL((Integer)1,"all"),
    REVIEW((Integer)2,"review"),
    DATE((Integer)3,"date"),
    SALECOUNT((Integer)4,"saleCount"),
    PRICE((Integer)5,"price");

    @Getter
    @Setter
    private Integer flag;

    @Getter
    @Setter
    private String desc;

    SortMehodEnum(Integer flag,String desc){
        this.flag = flag;
        this.desc = desc;
    }
}
