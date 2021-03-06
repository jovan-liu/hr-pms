package com.lzh.hr.pms.request;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class OvertimeRequest {

	private String empNumber;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date beginDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date endDate;
	
}
