package com.lzh.hr.pms.service;

import java.util.List;

import com.lzh.hr.pms.entity.Attendance;
import com.lzh.hr.pms.request.AttendanceRequest;
import com.lzh.hr.pms.response.Page;

public interface AttendanceService {

	Attendance findById(Integer id);
	
	List<Attendance> findAll();
	
	Boolean save(Attendance attendance);
	
	Boolean update(Attendance attendance);
	
	Boolean refresh(Integer id);
	
	Page<Attendance> findByPage(AttendanceRequest request, Integer pageNum, Integer pageSize);
	
	Attendance findTodayAttendance(String empNumber);
	
}
