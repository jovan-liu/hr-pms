package com.lzh.hr.pms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.lzh.hr.pms.entity.Leave;
import com.lzh.hr.pms.request.LeaveRequest;

public interface LeaveDao {

	Leave findById(Integer id);
	
	Long countAllLeave();
	
	List<Leave> findAll();
	
	Boolean save(Leave leave);
	
	Boolean update(Leave leave);
	
	Long countLeave(LeaveRequest request);
	
	List<Leave> findByPage(@Param("param") LeaveRequest request, @Param("start") Long start, @Param("limit") Integer limit);
	
}
