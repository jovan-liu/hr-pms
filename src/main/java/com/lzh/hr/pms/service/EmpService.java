package com.lzh.hr.pms.service;

import java.util.List;

import com.lzh.hr.pms.dto.EmpDTO;
import com.lzh.hr.pms.entity.Emp;
import com.lzh.hr.pms.response.Page;

public interface EmpService {

	Emp findEmpById(Integer id);
	
	List<Emp> findAll();
	
	Page<Emp> findByPage(EmpDTO empDto, Integer pageNum, Integer pageSize);
	
	Boolean save(Emp emp);
	
	Boolean update(Emp emp);
	
	Boolean deleteById(Integer id);
	
	Boolean leaveById(Integer id);
}
