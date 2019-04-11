package com.lzh.hr.pms.enums;

public enum LeaveStatus {
	
	PENDING(0, "待审核"),
	ACCEPTED(1, "已通过"),
	REJECTED(2, "未通过");
	
	LeaveStatus(Integer statusCode, String statusName) {
		this.statusCode = statusCode;
		this.statusName = statusName;
	}
	
	private Integer statusCode;
	private String statusName;
	
	public Integer getStatusCode() {
		return statusCode;
	}
	public void setStatusCode(Integer statusCode) {
		this.statusCode = statusCode;
	}
	public String getStatusName() {
		return statusName;
	}
	public void setStatusName(String statusName) {
		this.statusName = statusName;
	}
	
}
