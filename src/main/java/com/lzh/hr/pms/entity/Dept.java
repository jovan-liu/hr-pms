package com.lzh.hr.pms.entity;

import java.io.Serializable;

import lombok.Data;

/**
 * 部门实体类
 */
/*
 * 使用lombok插件简化Getter/Setter操作
 */
@Data
public class Dept implements Serializable {

	private Integer id;
	private String name;
	private String desc;
	private Boolean status;
	
}
