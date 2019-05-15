package com.lzh.hr.pms.service;

import java.util.List;

import com.lzh.hr.pms.entity.Salary;
import com.lzh.hr.pms.request.SalaryRequest;
import com.lzh.hr.pms.response.Page;

public interface SalaryService {

	Salary findById(Integer id);
	
	List<Salary> findAll();
	
	Boolean generate();
	
	Boolean generateByMonth(Integer month);
	
	Boolean update(Salary salary);
	
	Boolean batchUpdate();
	
	Page<Salary> findByPage(SalaryRequest request, Integer pageNum, Integer pageSize);
	
}
