package com.lzh.hr.pms.dao;

import java.util.List;

import com.lzh.hr.pms.entity.Dept;

public interface DeptDao {

	Dept findDeptById(Integer id);
	
	List<Dept> findAll();
	
	Boolean save(Dept dept);
	
	Boolean update(Dept dept);
	
	Boolean deleteById(Integer id);
	
}
