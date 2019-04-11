package com.lzh.hr.pms.entity;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

/**
 * 加请假体类
 */
@Data
public class Leave implements Serializable {

	private Integer id; // 请假记录ID
	private String empNumber; // 员工编号
	private Integer type; // 请假类型
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	private Date startTime; // 开始时间
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	private Date endTime; // 结束时间
	private String reason; // 请假理由
	private Integer status; // 状态 1. 待审核 2. 已通过 3. 未通过
	private Date applyTime; // 申请时间
	private Date replyTime; // 批准时间
	private String createUserName; // 创建人
	private Date createdOn; // 创建时间
	private String updateUserName; // 更新人
	private Date updatedOn; // 更新时间
	
}
