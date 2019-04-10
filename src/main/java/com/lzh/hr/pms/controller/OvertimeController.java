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

import com.lzh.hr.pms.entity.Overtime;
import com.lzh.hr.pms.entity.OperateLog;
import com.lzh.hr.pms.request.OvertimeRequest;
import com.lzh.hr.pms.response.Page;
import com.lzh.hr.pms.service.OvertimeService;


@Controller
@RequestMapping("/overtime")
public class OvertimeController extends BaseController {
	
	@Autowired
	private OvertimeService overtimeService;

	@RequestMapping(value = "/overtime-list")
	public String getOvertimeList(HttpServletRequest request, Model model, Integer pageNumber, OvertimeRequest overtimeReq) throws JSONException {
		String worker = SecurityUtils.getSubject().getPrincipal() == null ? ""
				: SecurityUtils.getSubject().getPrincipal().toString();
		overtimeReq.setEmpNumber(worker);
		Page<Overtime> overtimeList = overtimeService.findByPage(overtimeReq, pageNumber, 20);
		model.addAttribute("pageNumber", pageNumber);
		model.addAttribute("overtimeList", overtimeList);
		model.addAttribute("overtimeRequest", overtimeReq);
		return "forward:/overtime/overtime-list.jsp";
    }

    @RequestMapping(value = "/overtime-add")
	public String addMod(HttpServletRequest request, @ModelAttribute("overtime") Overtime overtime) throws InterruptedException {
    	boolean flag = overtimeService.save(overtime);
		if (flag) {
			OperateLog operateLog = new OperateLog();
			operateLog.setWorker(SecurityUtils.getSubject().getPrincipal() == null ? ""
					: SecurityUtils.getSubject().getPrincipal().toString());
			operateLog.setCreatetime(new Date());
			operateLog.setOperateLog("加班保存成功:" + overtime.getEmpNumber());
			operateLogService.insert(operateLog);
		}
		return "redirect:/overtime/overtime-list";
	}
    

	@RequestMapping(value = "/overtime-update")
	public String updateMod(HttpServletRequest request, Overtime overtime, String del2)
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
		return "redirect:/overtime/overtime-list";
	}
	
	@RequestMapping(value = "/overtime-add-show")
	public String addModShow(HttpServletRequest request, Model model) {
		return "forward:/overtime/overtime-add-show.jsp";
	}

    @RequestMapping(value = "/overtime-edit-show")
	public String updateModShow(HttpServletRequest request, Integer id, Model model) {
		Overtime overtime = overtimeService.findById(id);
		model.addAttribute("overtime", overtime);
		return "forward:/overtime/overtime-edit-show.jsp";
	}

}
