package com.lzh.hr.pms.enums;

/**
 * 请假类型
 */
public enum LeaveType {

	PERSONAL_LEAVE(1, "事假"),
	SICK_LEAVE(2, "病假"),
	ANNUAL_LEAVE(3, "年假");
	
	LeaveType(Integer typeCode, String typeName) {
		this.typeCode = typeCode;
		this.typeName = typeName;
	}
	
	private Integer typeCode;
	private String typeName;
	
	public Integer getTypeCode() {
		return typeCode;
	}
	public void setTypeCode(Integer typeCode) {
		this.typeCode = typeCode;
	}
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	
}
