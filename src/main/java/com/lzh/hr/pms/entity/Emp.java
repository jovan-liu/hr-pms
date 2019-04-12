package com.lzh.hr.pms.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

/**
 * 员工实体类
 */
@Data
public class Emp implements Serializable {

	private Integer id;
	private Integer deptId;
	private String deptName;
	private String name;
	private Integer age;
	private String IDCard;
	private String phone;
	private String email;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date birthday;
	private Integer sex; // 1男性 0女性
	private Boolean maritalStatus; // 1已婚 0未婚
	private String placeOfBirth;
	private String currentCity;
	private String photo;
	private String number;
	//private String password;
	private BigDecimal salary;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date hiredate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date offdate;
	private Boolean status; // 1在职 0离职
	private String createUserName;
	private Date createdOn;
	private String updateUserName;
	private Date updatedOn;

}
