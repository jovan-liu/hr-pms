package com.lzh.hr.pms.mapper.test;

import java.util.Date;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.lzh.hr.pms.dao.DeptDao;
import com.lzh.hr.pms.entity.Dept;
import com.lzh.hr.pms.entity.Emp;
import com.lzh.hr.pms.service.EmpService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:spring-context.xml", "classpath:spring-context-druid.xml", "classpath:spring-context-mybatis.xml"})
public class EmpServiceTest {

	@Autowired
	private EmpService empService;
	@Autowired
	private DeptDao deptDao;
	
	@Test
	public void testSave() {
		Emp emp = new Emp();
		Dept dept = deptDao.findDeptById(1);
		emp.setDeptId(dept.getId());
		emp.setDeptName(dept.getName());
		emp.setName("jovan2");
		emp.setAge(18);
		emp.setIDCard("460033199401291122");
		emp.setPhone("15344445555");
		emp.setEmail("jovan@sky.com");
		emp.setSex(1);
		emp.setMaritalStatus(false);
		emp.setPlaceOfBirth("广东省广州市");
		emp.setCurrentCity("广东省深圳市宝安区");
		emp.setHiredate(new Date());
		
		empService.save(emp);
		
	}
}
