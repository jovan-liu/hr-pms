package com.lzh.hr.pms.entity;

import java.util.Date;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class TCategory {

	private Long id;
	private String vendorId;
	private Integer status;
	private String categoryName;
	private Long parentId;
	private String creator;
	private Date updateTime;
	private Date createTime;
	
}
