package com.lzh.hr.pms.controller;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lzh.hr.pms.entity.Attendance;
import com.lzh.hr.pms.entity.OperateLog;
import com.lzh.hr.pms.request.AttendanceRequest;
import com.lzh.hr.pms.response.Page;
import com.lzh.hr.pms.service.AttendanceService;


@Controller
@RequestMapping("/emp-attendance")
public class EmpAttendanceController extends BaseController {
	
	@Autowired
	private AttendanceService attendanceService;

	@RequestMapping(value = "/emp-attendance-list")
	public String getAttendanceList(HttpServletRequest request, Model model, Integer pageNumber, AttendanceRequest attendanceReq) throws JSONException {
		
		Page<Attendance> attendanceList = attendanceService.findByPage(attendanceReq, pageNumber, 20);
		model.addAttribute("pageNumber", pageNumber);
		model.addAttribute("attendanceList", attendanceList);
		model.addAttribute("attendanceRequest", attendanceReq);
		return "forward:/emp-attendance/emp-attendance-list.jsp";
    }

	@RequestMapping(value = "/emp-attendance-update")
	public String updateMod(HttpServletRequest request, Attendance attendance)
			throws InterruptedException {
		boolean flag = attendanceService.update(attendance); 
		if (flag) {
			OperateLog operateLog = new OperateLog();
			operateLog.setWorker(SecurityUtils.getSubject().getPrincipal() == null ? ""
					: SecurityUtils.getSubject().getPrincipal().toString());
			operateLog.setCreatetime(new Date());
			operateLog.setOperateLog("考勤更新:" + attendance.getEmpNumber());
			operateLogService.insert(operateLog);
		}
		return "redirect:/emp-attendance/emp-attendance-list";
	}

}
