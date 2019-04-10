package com.lzh.hr.pms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.lzh.hr.pms.entity.Attendance;
import com.lzh.hr.pms.request.AttendanceRequest;

public interface AttendanceDao {

	Attendance findById(Integer id);
	
	Long countAllAttendance();
	
	List<Attendance> findAll();
	
	//Long countAllAttendanceByEmpNumber(String empNumber);
	
	//List<Attendance> findAllByEmpNumber(String empNumber);
	
	Boolean save(Attendance attendance);
	
	Boolean update(Attendance attendance);
	
	Long countAttendance(AttendanceRequest request);
	
	/**
	 * 分页查询
	 * 根据员工编号与时间进行分页
	 * 1. 时间小于今天
	 * 2. 时间为今天前的一个月内
	 * select * from emp_attendance where emp_number = 'SKU0001' and attendance_date < current_date()
	 * @param start
	 * @param limit
	 * @return
	 */
	List<Attendance> findByPage(@Param("param") AttendanceRequest request, @Param("start") Long start, @Param("limit") Integer limit);
	
	/**
	 * 查询当日考勤记录
	 * select * from emp_attendance where emp_number = #{empNumber} and attendance_date = current_date()
	 * @param empNumber 员工编号
	 * @return
	 */
	Attendance findTodayAttendance(String empNumber);
	
}
