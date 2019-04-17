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

import com.lzh.hr.pms.entity.Salary;
import com.lzh.hr.pms.entity.OperateLog;
import com.lzh.hr.pms.request.SalaryRequest;
import com.lzh.hr.pms.response.Page;
import com.lzh.hr.pms.service.SalaryService;


@Controller
@RequestMapping("/emp-salary")
public class EmpSalaryController extends BaseController {
	
	@Autowired
	private SalaryService salaryService;

	@RequestMapping(value = "/emp-salary-list")
	public String getSalaryList(HttpServletRequest request, Model model, Integer pageNumber, SalaryRequest salaryReq) throws JSONException {
		Page<Salary> salaryList = salaryService.findByPage(salaryReq, pageNumber, 20);
		model.addAttribute("pageNumber", pageNumber);
		model.addAttribute("salaryList", salaryList);
		model.addAttribute("salaryRequest", salaryReq);
		return "forward:/emp-salary/emp-salary-list.jsp";
    }

	@RequestMapping(value = "/emp-salary-update")
	@ResponseBody
	public Map<String, Object> updateMod(HttpServletRequest request, Salary salary)
			throws InterruptedException {
		Map<String, Object> data = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		boolean flag = salaryService.update(salary); 
		if (flag) {
			OperateLog operateLog = new OperateLog();
			operateLog.setWorker(SecurityUtils.getSubject().getPrincipal() == null ? ""
					: SecurityUtils.getSubject().getPrincipal().toString());
			operateLog.setCreatetime(new Date());
			operateLog.setOperateLog("薪资更新:" + salary.getEmpNumber());
			operateLogService.insert(operateLog);
		}
		map.put("result", flag);
		data.put("data", map);
		data.put("status", "success");
		return data;
	}

}
