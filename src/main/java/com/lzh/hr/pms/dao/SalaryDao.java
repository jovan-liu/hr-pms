package com.lzh.hr.pms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.lzh.hr.pms.entity.Salary;
import com.lzh.hr.pms.request.SalaryRequest;

public interface SalaryDao {

	Salary findById(Integer id);
	
	Long countAllSalary();
	
	List<Salary> findAll();
	
	Boolean save(Salary salary);
	
	Boolean update(Salary salary);
	
	Boolean batchUpdate(Salary salary);
	
	Long countSalary(SalaryRequest request);
	
	List<Salary> findByPage(@Param("param") SalaryRequest request, @Param("start") Long start, @Param("limit") Integer limit);
	
}
