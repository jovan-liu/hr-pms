package com.lzh.hr.pms.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lzh.hr.pms.entity.Leave;
import com.lzh.hr.pms.entity.OperateLog;
import com.lzh.hr.pms.request.LeaveRequest;
import com.lzh.hr.pms.response.Page;
import com.lzh.hr.pms.service.LeaveService;


@Controller
@RequestMapping("/emp-leave")
public class EmpLeaveController extends BaseController {
	
	@Autowired
	private LeaveService leaveService;

	@RequestMapping(value = "/emp-leave-list")
	public String getLeaveList(HttpServletRequest request, Model model, Integer pageNumber, LeaveRequest leaveReq) throws JSONException {
		Page<Leave> leaveList = leaveService.findByPage(leaveReq, pageNumber, 20);
		model.addAttribute("pageNumber", pageNumber);
		model.addAttribute("leaveList", leaveList);
		model.addAttribute("leaveRequest", leaveReq);
		return "forward:/emp-leave/emp-leave-list.jsp";
    }

	@RequestMapping(value = "/emp-leave-update")
	@ResponseBody
	public Map<String, Object> updateMod(HttpServletRequest request, Leave leave)
			throws InterruptedException {
		Map<String, Object> data = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		boolean flag = leaveService.update(leave); 
		if (flag) {
			OperateLog operateLog = new OperateLog();
			operateLog.setWorker(SecurityUtils.getSubject().getPrincipal() == null ? ""
					: SecurityUtils.getSubject().getPrincipal().toString());
			operateLog.setCreatetime(new Date());
			operateLog.setOperateLog("请假更新:" + leave.getEmpNumber());
			operateLogService.insert(operateLog);
		}
		map.put("result", flag);
		data.put("data", map);
		data.put("status", "success");
		return data;
	}

}
