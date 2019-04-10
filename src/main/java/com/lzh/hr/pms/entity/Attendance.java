package com.lzh.hr.pms.entity;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

/**
 * 考勤实体类
 */
@Data
public class Attendance implements Serializable {

	private Integer id;
	private String empNumber; // 员工编号
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date attendanceDate; // 考勤日期
	@DateTimeFormat(pattern = "hh:mm")
	private Date signIn; // 签到时间
	@DateTimeFormat(pattern = "hh:mm")
	private Date signOut; // 签退时间
	private Integer count; // 打卡次数
	private Boolean late = false; // 迟到
	private Boolean left = false; // 早退
	private Float workTime; // 工作时间 = 签退- 签到
	/*
	 * 考勤状态 1正常 0异常
	 * 1. 第二天零点做定时任务处理
	 * 2. 查询考勤时进行判断
	 */
	private Integer status;
	
}
