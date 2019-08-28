package com.how2java.util;

import lombok.Data;

@Data
public class Page {

	int start=0;
	int count = 5;
	int last = 0;
	public final static int COUNT = 5;
	public void caculateLast(int total) {
	    // 假设总数是56，是能够被7整除的，那么最后一页的开始就是45
	    if (0 == total % count)
	        last = total - count;
	    // 假设总数是51，不能够被5整除的，那么最后一页的开始就是50
	    else
	        last = total - total % count;
	}



}
