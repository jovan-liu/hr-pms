package com.lzh.hr.pms.service.impl;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lzh.hr.pms.dao.LeaveDao;
import com.lzh.hr.pms.entity.Leave;
import com.lzh.hr.pms.enums.LeaveStatus;
import com.lzh.hr.pms.request.LeaveRequest;
import com.lzh.hr.pms.response.Page;
import com.lzh.hr.pms.service.LeaveService;

@Service
public class LeaveServiceImpl implements LeaveService {
	
	@Autowired
	private LeaveDao leaveDao;

	public Leave findById(Integer id) {
		return leaveDao.findById(id);
	}

	public List<Leave> findAll() {
		return leaveDao.findAll();
	}

	public Boolean save(Leave leave) {
		String empNumber = SecurityUtils.getSubject().getPrincipal() == null ? ""
				: SecurityUtils.getSubject().getPrincipal().toString();
		Date date = new Date();
		
		leave.setEmpNumber(empNumber);
		leave.setCreateUserName(empNumber);
		leave.setApplyTime(date);
		leave.setCreatedOn(date);
		leave.setStatus(LeaveStatus.PENDING.getStatusCode());
		
		return leaveDao.save(leave);
	}

	public Boolean update(Leave leave) {
		String worker = SecurityUtils.getSubject().getPrincipal() == null ? ""
				: SecurityUtils.getSubject().getPrincipal().toString();
		Date date = new Date();
		
		leave.setUpdateUserName(worker);
		leave.setReplyTime(date);
		leave.setUpdatedOn(date);
		return leaveDao.update(leave);
	}

	public Page<Leave> findByPage(LeaveRequest request, Integer pageNum, Integer pageSize) {
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
		List<Leave> list = leaveDao.findByPage(request, start, pageSize);
		Long count = leaveDao.countLeave(request);
		Page<Leave> leavePage = new Page<Leave>();
		leavePage.setPageNumber(pageNum);
		leavePage.setPageSize(pageSize);
		leavePage.setTotalPage(count % pageSize == 0 ? (count / pageSize) : (count / pageSize + 1));
		leavePage.setTotalRow(count);
		leavePage.setPageList(list);
		return leavePage;
	}

}
