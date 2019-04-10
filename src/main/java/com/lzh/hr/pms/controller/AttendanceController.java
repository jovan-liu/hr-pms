package com.lzh.hr.pms.controller;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lzh.hr.pms.entity.Attendance;
import com.lzh.hr.pms.entity.OperateLog;
import com.lzh.hr.pms.request.AttendanceRequest;
import com.lzh.hr.pms.response.Page;
import com.lzh.hr.pms.service.AttendanceService;


@Controller
@RequestMapping("/attendance")
public class AttendanceController extends BaseController {
	
	@Autowired
	private AttendanceService attendanceService;

	@RequestMapping(value = "/attendance-list")
	public String getAttendanceList(HttpServletRequest request, Model model, Integer pageNumber, AttendanceRequest attendanceReq) throws JSONException {
		String worker = SecurityUtils.getSubject().getPrincipal() == null ? ""
				: SecurityUtils.getSubject().getPrincipal().toString();
		attendanceReq.setEmpNumber(worker);
		Page<Attendance> attendanceList = attendanceService.findByPage(attendanceReq, pageNumber, 20);
		Attendance attendance = attendanceService.findTodayAttendance(worker);
		model.addAttribute("pageNumber", pageNumber);
		model.addAttribute("attendanceList", attendanceList);
		model.addAttribute("attendance", attendance);
		model.addAttribute("attendanceRequest", attendanceReq);
		return "forward:/attendance/attendance-list.jsp";
    }

    @RequestMapping(value = "/attendance-add")
	public String addMod(HttpServletRequest request, @ModelAttribute("attendance") Attendance attendance) throws InterruptedException {
    	boolean flag = attendanceService.save(attendance);
		if (flag) {
			OperateLog operateLog = new OperateLog();
			operateLog.setWorker(SecurityUtils.getSubject().getPrincipal() == null ? ""
					: SecurityUtils.getSubject().getPrincipal().toString());
			operateLog.setCreatetime(new Date());
			operateLog.setOperateLog("考勤保存成功:" + attendance.getEmpNumber());
			operateLogService.insert(operateLog);
		}
		return "redirect:/attendance/attendance-list";
	}
    

	@RequestMapping(value = "/attendance-update")
	public String updateMod(HttpServletRequest request, Attendance attendance, String del2)
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
		return "redirect:/attendance/attendance-list";
	}

    /*@RequestMapping(value = "/attendance-add-show")
	public String addModShow(HttpServletRequest request, Model model) {
		return "forward:/attendance/attendance-add-show.jsp";
	}

    @RequestMapping(value = "/attendance-edit-show")
	public String updateModShow(HttpServletRequest request, Integer id, Model model) {
		Attendance attendance = attendanceService.findById(id);
		model.addAttribute("attendance", attendance);
		return "forward:/attendance/attendance-edit-show.jsp";
	}*/
}
