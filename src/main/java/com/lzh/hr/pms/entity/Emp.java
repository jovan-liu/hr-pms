package com.lzh.hr.pms.entity;

import java.io.Serializable;
import java.util.Date;

import lombok.Data;

@Data
public class Emp implements Serializable {

	private Integer id;
	private String name;
	private Integer age;
	private String IDCard;
	private String phone;
	private String email;
	private Date birthday;
	private Integer sex; // 1男性 0女性
	private Boolean maritalStatus; // 1已婚 0未婚
	private String placeOfBirth;
	private String currentCity;
	private String photo;
	private String number;
	private String password;
	private Integer deptId;
	private Date hiredate;
	private Date offdate;
	private Boolean status; // 1在职 0离职
	private String createUserName;
	private Date createdOn;
	private String updateUserName;
	private Date updatedOn;

}
