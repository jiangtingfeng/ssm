package com.how2java.pojo;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.util.Date;

@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class Category {
	private int id;
	private String categoryName;
	private String categoryPic;
	private String updateUser;
	private Date updateDate;
}
