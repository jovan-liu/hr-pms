package com.lzh.hr.pms.service.impl;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lzh.hr.pms.dao.AttendanceDao;
import com.lzh.hr.pms.dao.EmpDao;
import com.lzh.hr.pms.dao.LeaveDao;
import com.lzh.hr.pms.dao.OvertimeDao;
import com.lzh.hr.pms.dao.SalaryDao;
import com.lzh.hr.pms.dao.WorkDateDao;
import com.lzh.hr.pms.entity.Attendance;
import com.lzh.hr.pms.entity.Emp;
import com.lzh.hr.pms.entity.Leave;
import com.lzh.hr.pms.entity.Overtime;
import com.lzh.hr.pms.entity.Salary;
import com.lzh.hr.pms.request.AttendanceRequest;
import com.lzh.hr.pms.request.LeaveRequest;
import com.lzh.hr.pms.request.OvertimeRequest;
import com.lzh.hr.pms.request.SalaryRequest;
import com.lzh.hr.pms.response.Page;
import com.lzh.hr.pms.service.SalaryService;

@Service
public class SalaryServiceImpl implements SalaryService {
	
	@Autowired
	private SalaryDao salaryDao;
	@Autowired
	private EmpDao empDao;
	@Autowired
	private AttendanceDao attendanceDao;
	@Autowired
	private OvertimeDao overtimeDao;
	@Autowired
	private LeaveDao leaveDao;
	@Autowired
	private WorkDateDao workDateDao;
	

	public Salary findById(Integer id) {
		return salaryDao.findById(id);
	}

	public List<Salary> findAll() {
		return salaryDao.findAll();
	}

	public Boolean save(Salary salary) {
		Date date = new Date();
		
		List<Emp> empList = empDao.findAll();
		Calendar cale = null;
		cale = Calendar.getInstance();
		cale.add(Calendar.MONTH, -1);
		cale.set(Calendar.DAY_OF_MONTH, 1);
		Date firstDayOfMonth = cale.getTime();
		
		cale.add(Calendar.MONTH, 1);
		cale.set(Calendar.DAY_OF_MONTH, 0);
		Date lastDayOfMonth = cale.getTime();
		
		DateFormat df = new SimpleDateFormat("yyyy-MM");
		DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		// 月份
		String salaryDate = df.format(cale.getTime());
		// 当月最大天数
		int maxDays = cale.get(Calendar.DATE);
		
		for (Emp emp : empList) {
			String number = emp.getNumber();
			// 月薪基本工资
			BigDecimal basicMoney = emp.getSalary();
			// 日薪
			BigDecimal dayMoney = basicMoney.divide(new BigDecimal(21.75), 2, BigDecimal.ROUND_DOWN);
			// 时薪
			BigDecimal hourMoney = dayMoney.divide(new BigDecimal(8), 2, BigDecimal.ROUND_DOWN);
			
			SalaryRequest salaryRequest = new SalaryRequest();
			salaryRequest.setEmpNumber(number);
			salaryRequest.setBeginDate(df.format(firstDayOfMonth));
			Long countSalary = salaryDao.countSalary(salaryRequest);
			if (countSalary > 0) {
				// 已经发放
				continue;
			}
			
			
			// 加班
			OvertimeRequest otRequest = new OvertimeRequest();
			otRequest.setEmpNumber(number);
			otRequest.setBeginDate(firstDayOfMonth);
			otRequest.setEndDate(lastDayOfMonth);
			List<Overtime> overtimeList = overtimeDao.findByPage(otRequest, 0L, 100);
			BigDecimal otMoney = new BigDecimal(0);
			for (Overtime overtime : overtimeList) {
				Date startTime = overtime.getStartTime();
				Date endTime = overtime.getEndTime();
				int startHour = startTime.getHours();
				int startMinute = startTime.getMinutes();
				
				int endHour = endTime.getHours();
				int endMinute = endTime.getMinutes();
				
				int otHour = endHour - startHour;
				int otMinute = endMinute - startMinute;
				if (otMinute > 30) {
					otHour += 0.5;
				}
				// 加班薪资总和
				otMoney.add(hourMoney.multiply(new BigDecimal(otHour)));
			}
			
			// 请假
			LeaveRequest leaveRequest = new LeaveRequest();
			leaveRequest.setEmpNumber(number);
			leaveRequest.setBeginDate(firstDayOfMonth);
			leaveRequest.setEndDate(lastDayOfMonth);
			List<Leave> leaveList = leaveDao.findByPage(leaveRequest, 0L, 100);
			BigDecimal leaveMoney = new BigDecimal(0);
			for (Leave leave : leaveList) {
				Date startTime = leave.getStartTime();
				Date endTime = leave.getEndTime();
				int startHour = startTime.getHours();
				int startMinute = startTime.getMinutes();
				
				int endHour = endTime.getHours();
				int endMinute = endTime.getMinutes();
				
				int leaveHour = endHour - startHour;
				int leaveMinute = endMinute - startMinute;
				if (leaveMinute > 30) {
					leaveHour += 0.5;
				}
				// 请假扣除薪资总和
				leaveMoney.add(hourMoney.multiply(new BigDecimal(leaveHour)));
			}
			
			// 考勤
			AttendanceRequest attendanceRequest = new AttendanceRequest();
			attendanceRequest.setEmpNumber(number);
			attendanceRequest.setBeginDate(firstDayOfMonth);
			attendanceRequest.setEndDate(lastDayOfMonth);
			Long attendanceCount = attendanceDao.countAttendance(attendanceRequest);
			
			List<Attendance> attendanceList = attendanceDao.findByPage(attendanceRequest, 0L, 100);
			int countLate = 0;
			for (Attendance attendance : attendanceList) {
				countLate += attendance.getCountLate();
			}
			
			Long workCount = workDateDao.countWorkDate(sdf.format(firstDayOfMonth), sdf.format(lastDayOfMonth));
			
			// 实际发放			
			BigDecimal actualMoney = new BigDecimal(0);
			// 考勤天数与节假日天数相加等于当月天数
			if (attendanceCount + workCount == maxDays) {
				// 全勤则发放200元奖金
				actualMoney = basicMoney.add(otMoney).subtract(leaveMoney).add(new BigDecimal(200));
				salary.setBonus(new BigDecimal(200));
			} else {
				// 考勤天数与工作日不一致，存在异常，扣除200元
				actualMoney = basicMoney.add(otMoney).subtract(leaveMoney).subtract(new BigDecimal(200));
				salary.setBonus(new BigDecimal(-200));
			}
			
			// 迟到早退3天则扣除100元
			if (countLate > 3) {
				actualMoney = basicMoney.add(otMoney).subtract(leaveMoney).subtract(new BigDecimal(100));
				salary.setBonus(new BigDecimal(-100));
				salary.setLateMoney(new BigDecimal(-100));
			} else {
				salary.setLateMoney(new BigDecimal(0));
			}
			
			salary.setEmpNumber(number);
			salary.setSalaryDate(salaryDate);
			salary.setWorkCount(Integer.valueOf(attendanceCount.toString()));
			salary.setBasicMoney(basicMoney);
			salary.setOtMoney(otMoney);
			salary.setLeaveMoney(leaveMoney);
			salary.setActualMoney(actualMoney);
			salary.setStatus(0);
			salary.setCreateUserName("SYSTEM");
			salary.setCreatedOn(date);
			salaryDao.save(salary);
		}
		
		
		return null;
	}

	public Boolean update(Salary salary) {
		String worker = SecurityUtils.getSubject().getPrincipal() == null ? ""
				: SecurityUtils.getSubject().getPrincipal().toString();
		Date date = new Date();
		
		salary.setStatus(1);
		salary.setUpdateUserName(worker);
		salary.setUpdatedOn(date);
		return salaryDao.update(salary);
	}

	public Page<Salary> findByPage(SalaryRequest request, Integer pageNum, Integer pageSize) {
		if (pageNum == null) {
			pageNum = 1;
		}
		if (pageSize == null) {
			pageSize = 20;
		}
		if (request != null) {
			Calendar cale = null;
			DateFormat sdf = new SimpleDateFormat("yyyy-MM");
			if (request.getBeginDate() == null) {
				cale = Calendar.getInstance();
				cale.add(Calendar.MONTH, 0);
				cale.set(Calendar.DAY_OF_MONTH, 1);
				request.setBeginDate(sdf.format(cale.getTime()));
			}
			if (request.getEndDate() == null) {
				cale = Calendar.getInstance();
				cale.add(Calendar.MONTH, 1);
				cale.set(Calendar.DAY_OF_MONTH, 0);
				request.setEndDate(sdf.format(cale.getTime()));
			}
		}
		
		Long start = new Long(pageSize * (pageNum - 1));
		List<Salary> list = salaryDao.findByPage(request, start, pageSize);
		Long count = salaryDao.countSalary(request);
		Page<Salary> salaryPage = new Page<Salary>();
		salaryPage.setPageNumber(pageNum);
		salaryPage.setPageSize(pageSize);
		salaryPage.setTotalPage(count % pageSize == 0 ? (count / pageSize) : (count / pageSize + 1));
		salaryPage.setTotalRow(count);
		salaryPage.setPageList(list);
		return salaryPage;
	}

}
