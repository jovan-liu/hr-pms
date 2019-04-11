package com.lzh.hr.pms.service;

import java.util.List;

import com.lzh.hr.pms.entity.Leave;
import com.lzh.hr.pms.request.LeaveRequest;
import com.lzh.hr.pms.response.Page;

public interface LeaveService {

	Leave findById(Integer id);
	
	List<Leave> findAll();
	
	Boolean save(Leave leave);
	
	Boolean update(Leave leave);
	
	Page<Leave> findByPage(LeaveRequest request, Integer pageNum, Integer pageSize);
	
}
