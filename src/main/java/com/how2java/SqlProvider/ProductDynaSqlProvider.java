package com.how2java.SqlProvider;


import org.apache.ibatis.jdbc.SQL;

public class ProductDynaSqlProvider {

    public String list(){
        return new SQL()
                .SELECT("*")
                .FROM("product_")
                .toString();
    }
    public String get(){
        return new SQL()
                .SELECT("*")
                .FROM("product_")
                .WHERE("id=#{id}")
                .toString();
    }

    public String add(){
        return new SQL()
                .INSERT_INTO("product_")
                .VALUES("name","#{name}")
                .toString();
    }

    public String update(){
        return new SQL()
                .UPDATE("product_")
                .SET("name=#{name}")
                .WHERE("id=#{id}")
                .toString();
    }

    public String delete() {
        return new SQL()
                .DELETE_FROM("product_")
                .WHERE("id=#{id}")
                .toString();
    }

}
