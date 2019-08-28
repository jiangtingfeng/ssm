package com.how2java.util;
/*
* 获取4为随机数的验证码
* */
public class RandomUtil {
    public static int getRandNum() {
        return (int)((Math.random()*9+1)*1000);
    }
}
