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

import com.lzh.hr.pms.entity.Leave;
import com.lzh.hr.pms.entity.OperateLog;
import com.lzh.hr.pms.request.LeaveRequest;
import com.lzh.hr.pms.response.Page;
import com.lzh.hr.pms.service.LeaveService;


@Controller
@RequestMapping("/leave")
public class LeaveController extends BaseController {
	
	@Autowired
	private LeaveService leaveService;

	@RequestMapping(value = "/leave-list")
	public String getLeaveList(HttpServletRequest request, Model model, Integer pageNumber, LeaveRequest leaveReq) throws JSONException {
		String worker = SecurityUtils.getSubject().getPrincipal() == null ? ""
				: SecurityUtils.getSubject().getPrincipal().toString();
		leaveReq.setEmpNumber(worker);
		Page<Leave> leaveList = leaveService.findByPage(leaveReq, pageNumber, 20);
		model.addAttribute("pageNumber", pageNumber);
		model.addAttribute("leaveList", leaveList);
		model.addAttribute("leaveRequest", leaveReq);
		return "forward:/leave/leave-list.jsp";
    }

    @RequestMapping(value = "/leave-add")
	public String addMod(HttpServletRequest request, @ModelAttribute("leave") Leave leave) throws InterruptedException {
    	boolean flag = leaveService.save(leave);
		if (flag) {
			OperateLog operateLog = new OperateLog();
			operateLog.setWorker(SecurityUtils.getSubject().getPrincipal() == null ? ""
					: SecurityUtils.getSubject().getPrincipal().toString());
			operateLog.setCreatetime(new Date());
			operateLog.setOperateLog("请假保存成功:" + leave.getEmpNumber());
			operateLogService.insert(operateLog);
		}
		return "redirect:/leave/leave-list";
	}
    

	@RequestMapping(value = "/leave-update")
	public String updateMod(HttpServletRequest request, Leave leave)
			throws InterruptedException {
		boolean flag = leaveService.update(leave); 
		if (flag) {
			OperateLog operateLog = new OperateLog();
			operateLog.setWorker(SecurityUtils.getSubject().getPrincipal() == null ? ""
					: SecurityUtils.getSubject().getPrincipal().toString());
			operateLog.setCreatetime(new Date());
			operateLog.setOperateLog("请假更新:" + leave.getEmpNumber());
			operateLogService.insert(operateLog);
		}
		return "redirect:/leave/leave-list";
	}
	
	@RequestMapping(value = "/leave-add-show")
	public String addModShow(HttpServletRequest request, Model model) {
		return "forward:/leave/leave-add-show.jsp";
	}

    @RequestMapping(value = "/leave-edit-show")
	public String updateModShow(HttpServletRequest request, Integer id, Model model) {
		Leave leave = leaveService.findById(id);
		model.addAttribute("leave", leave);
		return "forward:/leave/leave-edit-show.jsp";
	}

}
