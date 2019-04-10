package com.lzh.hr.pms.service;

import java.util.List;

import com.lzh.hr.pms.entity.Overtime;
import com.lzh.hr.pms.request.OvertimeRequest;
import com.lzh.hr.pms.response.Page;

public interface OvertimeService {

	Overtime findById(Integer id);
	
	List<Overtime> findAll();
	
	Boolean save(Overtime overtime);
	
	Boolean update(Overtime overtime);
	
	Page<Overtime> findByPage(OvertimeRequest request, Integer pageNum, Integer pageSize);
	
}
