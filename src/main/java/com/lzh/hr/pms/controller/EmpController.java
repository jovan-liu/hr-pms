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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lzh.hr.pms.dto.EmpDTO;
import com.lzh.hr.pms.entity.Emp;
import com.lzh.hr.pms.entity.OperateLog;
import com.lzh.hr.pms.response.Page;
import com.lzh.hr.pms.service.DeptService;
import com.lzh.hr.pms.service.EmpService;


@Controller
@RequestMapping("/emp")
public class EmpController extends BaseController {
	
	@Autowired
	private EmpService empService;
	@Autowired
	private DeptService deptService;

	@RequestMapping(value = "/emp-list")
	public String getEmpList(HttpServletRequest request, Model model, Integer pageNumber, EmpDTO empDto) throws JSONException {
		//model.addAttribute("empList", empService.findAll());
		Page<Emp> empList = empService.findByPage(empDto, pageNumber, 20);
		model.addAttribute("pageNumber", pageNumber);
		model.addAttribute("empList", empList);
		model.addAttribute("empDto", empDto);
		return "forward:/emp/emp-list.jsp";
    }

	@RequestMapping(value = "/delete", produces = { "application/json;charset=UTF-8" })
    @ResponseBody
	public Map<String, Object> deleteEmp(HttpServletRequest request, Model model, Integer id) throws Exception {
		Map<String, Object> data = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		boolean flag = empService.deleteById(id);
		if (flag) {
			OperateLog operateLog = new OperateLog();
			operateLog.setWorker(SecurityUtils.getSubject().getPrincipal() == null ? ""
					: SecurityUtils.getSubject().getPrincipal().toString());
			operateLog.setCreatetime(new Date());
			operateLog.setOperateLog("删除部门序号:" + id);
			operateLogService.insert(operateLog);
		}
		map.put("result", flag);
		data.put("data", map);
		data.put("status", "success");
		return data;
	}

    @RequestMapping(value = "/emp-add")
	public String addMod(HttpServletRequest request, @ModelAttribute("emp") Emp emp) throws InterruptedException {
		boolean flag = empService.save(emp);
		if (flag) {
			OperateLog operateLog = new OperateLog();
			operateLog.setWorker(SecurityUtils.getSubject().getPrincipal() == null ? ""
					: SecurityUtils.getSubject().getPrincipal().toString());
			operateLog.setCreatetime(new Date());
			operateLog.setOperateLog("部门保存成功:" + emp.getName());
			operateLogService.insert(operateLog);
		}
		return "redirect:/emp/emp-list";
	}

	@RequestMapping(value = "/emp-update")
	public String updateMod(HttpServletRequest request, Emp emp)
			throws InterruptedException {
		boolean flag = empService.update(emp); 
		if (flag) {
			OperateLog operateLog = new OperateLog();
			operateLog.setWorker(SecurityUtils.getSubject().getPrincipal() == null ? ""
					: SecurityUtils.getSubject().getPrincipal().toString());
			operateLog.setCreatetime(new Date());
			operateLog.setOperateLog("部门更新:" + emp.getName());
			operateLogService.insert(operateLog);
		}
		return "redirect:/emp/emp-list";
	}

    @RequestMapping(value = "/emp-add-show")
	public String addModShow(HttpServletRequest request, Model model) {
    	model.addAttribute("deptList", deptService.findAll());
		return "forward:/emp/emp-add-show.jsp";
	}

    @RequestMapping(value = "/emp-edit-show")
	public String updateModShow(HttpServletRequest request, Integer id, Model model) {
		Emp emp = empService.findEmpById(id);
		model.addAttribute("emp", emp);
		model.addAttribute("deptList", deptService.findAll());
		return "forward:/emp/emp-edit-show.jsp";
	}
}
