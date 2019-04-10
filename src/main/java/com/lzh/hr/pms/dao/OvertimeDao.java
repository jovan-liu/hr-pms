package com.lzh.hr.pms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.lzh.hr.pms.entity.Overtime;
import com.lzh.hr.pms.request.OvertimeRequest;

public interface OvertimeDao {

	Overtime findById(Integer id);
	
	Long countAllOvertime();
	
	List<Overtime> findAll();
	
	Boolean save(Overtime overtime);
	
	Boolean update(Overtime overtime);
	
	Long countOvertime(OvertimeRequest request);
	
	List<Overtime> findByPage(@Param("param") OvertimeRequest request, @Param("start") Long start, @Param("limit") Integer limit);
	
}
