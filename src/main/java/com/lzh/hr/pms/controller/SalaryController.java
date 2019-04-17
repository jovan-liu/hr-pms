package com.lzh.hr.pms.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lzh.hr.pms.entity.Salary;
import com.lzh.hr.pms.request.SalaryRequest;
import com.lzh.hr.pms.response.Page;
import com.lzh.hr.pms.service.SalaryService;


@Controller
@RequestMapping("/salary")
public class SalaryController extends BaseController {
	
	@Autowired
	private SalaryService salaryService;

	@RequestMapping(value = "/salary-list")
	public String getSalaryList(HttpServletRequest request, Model model, Integer pageNumber, SalaryRequest salaryReq) throws JSONException {
		String worker = SecurityUtils.getSubject().getPrincipal() == null ? ""
				: SecurityUtils.getSubject().getPrincipal().toString();
		salaryReq.setEmpNumber(worker);
		Page<Salary> salaryList = salaryService.findByPage(salaryReq, pageNumber, 20);
		model.addAttribute("pageNumber", pageNumber);
		model.addAttribute("salaryList", salaryList);
		model.addAttribute("salaryRequest", salaryReq);
		return "forward:/salary/salary-list.jsp";
    }

}
