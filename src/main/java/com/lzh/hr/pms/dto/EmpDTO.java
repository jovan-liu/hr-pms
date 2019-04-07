package com.lzh.hr.pms.dto;

import java.io.Serializable;

import lombok.Data;

@Data
public class EmpDTO implements Serializable {

	private String number;
	private String name;
	private String deptName;
	private Boolean status;
	
}
