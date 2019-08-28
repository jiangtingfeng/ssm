package com.how2java.util;
/*
* 连接第三方平台 短信模块  生成验证码
* */

import org.apache.commons.httpclient.Header;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;

import java.io.IOException;
import java.util.HashMap;

/**
 * Created by JTF
 */
public class SendUtil {

    public static HashMap<String,String> getMessageStatus(String phone) throws IOException {
        HashMap<String,String> hashMap = new HashMap<>();
        //第三方平台网站地址 http://www.webchinese.com.cn/User/?action=pay
        PostMethod post = new PostMethod("http://utf8.api.smschinese.cn/");
        post.addRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=utf-8");
        String randMun = String.valueOf(RandomUtil.getRandNum());
        //短信模板
        NameValuePair[] data ={
                new NameValuePair("Uid", "jiangtingfeng"),  //sms短信通 注册的用户名
                new NameValuePair("Key", "d41d8cd98f00b204e980"), //密匙
                new NameValuePair("smsMob",phone),//要发送的手机号
                new NameValuePair("smsText","验证码:"+randMun+"，发送")//短信内容
        };
        post.setRequestBody(data);
        HttpClient client = new HttpClient();
        client.executeMethod(post);
        //获取http头
        Header[] headers = post.getResponseHeaders();
        int statusCode = post.getStatusCode();
        System.out.println("statusCode:"+statusCode);

        for(Header h:headers){
            System.out.println(h.toString());
        }
        //获取返回消息
        String result = new String(post.getResponseBodyAsString().getBytes("utf-8"));
        System.out.println(result); //打印返回消息状态
        //将返回消息和6位数验证码放入到map列表里面
        hashMap.put("result", result);
        hashMap.put("code", randMun);
        //断开与第三方平台的连接
        post.releaseConnection();
        return hashMap;
    }
}