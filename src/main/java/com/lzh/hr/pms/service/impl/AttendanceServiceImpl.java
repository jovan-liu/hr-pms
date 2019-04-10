package com.lzh.hr.pms.service.impl;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lzh.hr.pms.dao.AttendanceDao;
import com.lzh.hr.pms.entity.Attendance;
import com.lzh.hr.pms.request.AttendanceRequest;
import com.lzh.hr.pms.response.Page;
import com.lzh.hr.pms.service.AttendanceService;

@Service
public class AttendanceServiceImpl implements AttendanceService {
	
	@Autowired
	private AttendanceDao attendanceDao;

	public Attendance findById(Integer id) {
		return attendanceDao.findById(id);
	}

	public List<Attendance> findAll() {
		return attendanceDao.findAll();
	}

	public Boolean save(Attendance attendance) {
		String empNumber = SecurityUtils.getSubject().getPrincipal() == null ? ""
				: SecurityUtils.getSubject().getPrincipal().toString();
		Date date = new Date();
		
		attendance.setEmpNumber(empNumber);
		attendance.setAttendanceDate(date);
		attendance.setSignIn(date);
		attendance.setCount(1);
		attendance.setLate(false);
		
		return attendanceDao.save(attendance);
	}

	public Boolean update(Attendance attendance) {
		String empNumber = SecurityUtils.getSubject().getPrincipal() == null ? ""
				: SecurityUtils.getSubject().getPrincipal().toString();
		Attendance curAtten = attendanceDao.findTodayAttendance(empNumber);
		
		attendance.setEmpNumber(empNumber);
		attendance.setAttendanceDate(curAtten.getAttendanceDate());
		attendance.setSignOut(new Date());
		attendance.setLeft(false);
		attendance.setCount(curAtten.getCount() + 1);
		
		return attendanceDao.update(attendance);
	}

	public Page<Attendance> findByPage(AttendanceRequest request, Integer pageNum, Integer pageSize) {
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
		List<Attendance> list = attendanceDao.findByPage(request, start, pageSize);
		Long count = attendanceDao.countAttendance(request);
		Page<Attendance> attendancePage = new Page<Attendance>();
		attendancePage.setPageNumber(pageNum);
		attendancePage.setPageSize(pageSize);
		attendancePage.setTotalPage(count % pageSize == 0 ? (count / pageSize) : (count / pageSize + 1));
		attendancePage.setTotalRow(count);
		attendancePage.setPageList(list);
		return attendancePage;
	}

	public Attendance findTodayAttendance(String empNumber) {
		return attendanceDao.findTodayAttendance(empNumber);
	}

}
