package com.lzh.hr.pms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lzh.hr.pms.entity.Dept;
import com.lzh.hr.pms.dao.DeptDao;
import com.lzh.hr.pms.service.DeptService;

@Service
public class DeptServiceImpl implements DeptService {
	
	@Autowired
	private DeptDao deptDao;

	public Dept findDeptById(Integer id) {
		return deptDao.findDeptById(id);
	}

	public List<Dept> findAll() {
		return deptDao.findAll();
	}

	public Boolean save(Dept dept) {
		dept.setStatus(true);
		return deptDao.save(dept);
	}

	public Boolean update(Dept dept) {
		return deptDao.update(dept);
	}

	public Boolean deleteById(Integer id) {
		return deptDao.deleteById(id);
	}

}
