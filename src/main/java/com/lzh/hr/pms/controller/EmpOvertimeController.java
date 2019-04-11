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

import com.lzh.hr.pms.entity.Overtime;
import com.lzh.hr.pms.entity.OperateLog;
import com.lzh.hr.pms.request.OvertimeRequest;
import com.lzh.hr.pms.response.Page;
import com.lzh.hr.pms.service.OvertimeService;


@Controller
@RequestMapping("/emp-overtime")
public class EmpOvertimeController extends BaseController {
	
	@Autowired
	private OvertimeService overtimeService;

	@RequestMapping(value = "/emp-overtime-list")
	public String getOvertimeList(HttpServletRequest request, Model model, Integer pageNumber, OvertimeRequest overtimeReq) throws JSONException {
		Page<Overtime> overtimeList = overtimeService.findByPage(overtimeReq, pageNumber, 20);
		model.addAttribute("pageNumber", pageNumber);
		model.addAttribute("overtimeList", overtimeList);
		model.addAttribute("overtimeRequest", overtimeReq);
		return "forward:/emp-overtime/emp-overtime-list.jsp";
    }

	@RequestMapping(value = "/emp-overtime-update")
	@ResponseBody
	public Map<String, Object> updateMod(HttpServletRequest request, Overtime overtime)
			throws InterruptedException {
		Map<String, Object> data = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		boolean flag = overtimeService.update(overtime); 
		if (flag) {
			OperateLog operateLog = new OperateLog();
			operateLog.setWorker(SecurityUtils.getSubject().getPrincipal() == null ? ""
					: SecurityUtils.getSubject().getPrincipal().toString());
			operateLog.setCreatetime(new Date());
			operateLog.setOperateLog("加班更新:" + overtime.getEmpNumber());
			operateLogService.insert(operateLog);
		}
		map.put("result", flag);
		data.put("data", map);
		data.put("status", "success");
		return data;
	}

	@RequestMapping(value = "/emp-overtime-batch-update")
	public String batchUpdateMod(HttpServletRequest request, Overtime overtime)
			throws InterruptedException {
		boolean flag = overtimeService.update(overtime); 
		if (flag) {
			OperateLog operateLog = new OperateLog();
			operateLog.setWorker(SecurityUtils.getSubject().getPrincipal() == null ? ""
					: SecurityUtils.getSubject().getPrincipal().toString());
			operateLog.setCreatetime(new Date());
			operateLog.setOperateLog("加班更新:" + overtime.getEmpNumber());
			operateLogService.insert(operateLog);
		}
		return "redirect:/emp-overtime/emp-overtime-list";
	}

}
