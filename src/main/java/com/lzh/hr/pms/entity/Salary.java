package com.lzh.hr.pms.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import lombok.Data;

@Data
public class Salary implements Serializable {

	private Integer id; // 工资单记录ID
	private String empNumber; // 员工编号
	private String salaryDate; // 发放月份
	private Integer workCount; // 当月工作天数
	private BigDecimal basicMoney; // 基础工资
	private BigDecimal otMoney; // 加班工资
	private BigDecimal leaveMoney; // 请假工资（扣除）
	private BigDecimal bonus; // 全勤奖（200元）
	private BigDecimal lateMoney; // 迟到早退超过三次扣款100
	private BigDecimal actualMoney; // 实际发放
	private Integer status; // 状态 1已发 2未发
	private String createUserName; // 创建人
	private Date createdOn; // 创建时间
	private String updateUserName; // 更新人
	private Date updatedOn; // 更新时间
	
}
