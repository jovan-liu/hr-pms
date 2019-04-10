package com.lzh.hr.pms.service.impl;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lzh.hr.pms.dao.OvertimeDao;
import com.lzh.hr.pms.entity.Overtime;
import com.lzh.hr.pms.enums.OvertimeStatus;
import com.lzh.hr.pms.request.OvertimeRequest;
import com.lzh.hr.pms.response.Page;
import com.lzh.hr.pms.service.OvertimeService;

@Service
public class OvertimeServiceImpl implements OvertimeService {
	
	@Autowired
	private OvertimeDao overtimeDao;

	public Overtime findById(Integer id) {
		return overtimeDao.findById(id);
	}

	public List<Overtime> findAll() {
		return overtimeDao.findAll();
	}

	public Boolean save(Overtime overtime) {
		String empNumber = SecurityUtils.getSubject().getPrincipal() == null ? ""
				: SecurityUtils.getSubject().getPrincipal().toString();
		Date date = new Date();
		
		overtime.setEmpNumber(empNumber);
		overtime.setCreateUserName(empNumber);
		overtime.setApplyTime(date);
		overtime.setCreatedOn(date);
		overtime.setStatus(OvertimeStatus.PENDING.getStatusCode());
		
		return overtimeDao.save(overtime);
	}

	public Boolean update(Overtime overtime) {
		String worker = SecurityUtils.getSubject().getPrincipal() == null ? ""
				: SecurityUtils.getSubject().getPrincipal().toString();
		Date date = new Date();
		
		overtime.setUpdateUserName(worker);
		overtime.setReplyTime(date);
		overtime.setUpdatedOn(date);
		return overtimeDao.update(overtime);
	}

	public Page<Overtime> findByPage(OvertimeRequest request, Integer pageNum, Integer pageSize) {
		if (pageNum == null) {
			pageNum = 1;
		}
		if (pageSize == null) {
			pageSize = 20;
		}
		if (request != null) {
			Calendar cale = null;
			
			if (request.getBeginDate() == null) {
				cale = Calendar.getInstance();
				cale.add(Calendar.MONTH, 0);
				cale.set(Calendar.DAY_OF_MONTH, 1);
				request.setBeginDate(cale.getTime());
			}
			if (request.getEndDate() == null) {
				cale = Calendar.getInstance();
				cale.add(Calendar.MONTH, 1);
				cale.set(Calendar.DAY_OF_MONTH, 0);
				request.setEndDate(cale.getTime());
			}
		}
		
		Long start = new Long(pageSize * (pageNum - 1));
		List<Overtime> list = overtimeDao.findByPage(request, start, pageSize);
		Long count = overtimeDao.countOvertime(request);
		Page<Overtime> overtimePage = new Page<Overtime>();
		overtimePage.setPageNumber(pageNum);
		overtimePage.setPageSize(pageSize);
		overtimePage.setTotalPage(count % pageSize == 0 ? (count / pageSize) : (count / pageSize + 1));
		overtimePage.setTotalRow(count);
		overtimePage.setPageList(list);
		return overtimePage;
	}

}
