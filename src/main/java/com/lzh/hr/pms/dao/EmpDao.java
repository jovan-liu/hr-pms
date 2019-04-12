package com.lzh.hr.pms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.lzh.hr.pms.dto.EmpDTO;
import com.lzh.hr.pms.entity.Emp;

public interface EmpDao {

	Emp findEmpById(Integer id);
	
	List<Emp> findAll();
	
	Boolean save(Emp emp);
	
	Boolean update(Emp emp);
	
	Boolean deleteById(Integer id);
	
	Boolean leaveById(Integer id);
	
	Long countEmp(EmpDTO param);

	List<Emp> findEmp(@Param("param") EmpDTO param, @Param("start") Long start, @Param("limit") Integer limit);
	
}
