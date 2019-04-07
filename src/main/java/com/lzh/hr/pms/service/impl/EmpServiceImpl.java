package com.lzh.hr.pms.service.impl;

import java.util.Date;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lzh.hr.pms.entity.Account;
import com.lzh.hr.pms.entity.AccountAndRole;
import com.lzh.hr.pms.entity.Dept;
import com.lzh.hr.pms.entity.Emp;
import com.lzh.hr.pms.entity.Role;
import com.lzh.hr.pms.response.Page;
import com.lzh.hr.pms.dao.AccountAndRoleDao;
import com.lzh.hr.pms.dao.AccountDao;
import com.lzh.hr.pms.dao.DeptDao;
import com.lzh.hr.pms.dao.EmpDao;
import com.lzh.hr.pms.dao.EmpNumberDao;
import com.lzh.hr.pms.dao.RoleDao;
import com.lzh.hr.pms.dto.EmpDTO;
import com.lzh.hr.pms.service.EmpService;

@Service
public class EmpServiceImpl implements EmpService {
	
	@Autowired
	private EmpDao empDao;
	@Autowired
	private AccountDao accountDao;
	@Autowired
	private RoleDao roleDao;
	@Autowired
	private AccountAndRoleDao accountRoleDao;
	@Autowired
	private EmpNumberDao empNumberDao;
	@Autowired
	private DeptDao deptDao;

	public Emp findEmpById(Integer id) {
		return empDao.findEmpById(id);
	}

	public List<Emp> findAll() {
		return empDao.findAll();
	}
	
	public Page<Emp> findByPage(EmpDTO empDto, Integer pageNum, Integer pageSize) {
		if (pageNum == null) {
			pageNum = 1;
		}
		if (pageSize == null) {
			pageSize = 20;
		}
		Long start = new Long(pageSize * (pageNum - 1));
		List<Emp> list = empDao.findEmp(empDto, start, pageSize);
		Long count = empDao.countEmp(empDto);
		Page<Emp> empPage = new Page<Emp>();
		empPage.setPageNumber(pageNum);
		empPage.setPageSize(pageSize);
		empPage.setTotalPage(count % pageSize == 0 ? (count / pageSize) : (count / pageSize + 1));
		empPage.setTotalRow(count);
		empPage.setPageList(list);
		return empPage;
	}

	@Transactional
	public Boolean save(Emp emp) {
		// 查询上一位员工的工号
		// create table emp_number(number)
		// insert into emp_number(number) values(0)
		Integer preNumber = empNumberDao.findNumber();
		String number = String.format("SKY%04d", ++preNumber);
		
		
		// 新建普通员工对应的用户账号
		Account account = new Account();
		account.setUsername(number);
		account.setPassword(number);
		// account.setRoleList(roleList);
		account.setStatus(1);
		account.setCreateTime(new Date());
		accountDao.insert(account);
		
		// 插入用户对应的角色
		Role role = roleDao.findByRoleName("员工使用");
		AccountAndRole accountRole = new AccountAndRole();
		accountRole.setAccountId(account.getAccountId());
		accountRole.setRoleId(role.getId());
		accountRole.setCreateTime(new Date());
		accountRoleDao.insert(accountRole);
		
		// 更新员工编号
		empNumberDao.updateNumber(preNumber);
		
		// 登录用户（操作者）
		String worker = SecurityUtils.getSubject().getPrincipal() == null ? ""
				: SecurityUtils.getSubject().getPrincipal().toString();
		
		//String worker = "jovan";
		
		// 查询部门信息
		Dept dept = deptDao.findDeptById(emp.getDeptId());
		emp.setDeptName(dept.getName());
		
		// 保存员工信息
		emp.setNumber(number);
		emp.setStatus(true);
		emp.setCreateUserName(worker);
		emp.setCreatedOn(new Date());
		emp.setUpdateUserName(worker);
		emp.setUpdatedOn(new Date());
		return empDao.save(emp);
	}

	public Boolean update(Emp emp) {
		// 查询部门信息
		Dept dept = deptDao.findDeptById(emp.getDeptId());
		emp.setDeptName(dept.getName());
		String worker = SecurityUtils.getSubject().getPrincipal() == null ? ""
				: SecurityUtils.getSubject().getPrincipal().toString();
		emp.setUpdateUserName(worker);
		emp.setUpdatedOn(new Date());
		return empDao.update(emp);
	}

	public Boolean deleteById(Integer id) {
		return empDao.deleteById(id);
	}

}
