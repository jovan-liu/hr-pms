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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lzh.hr.pms.entity.Dept;
import com.lzh.hr.pms.entity.OperateLog;
import com.lzh.hr.pms.service.DeptService;


@Controller
@RequestMapping("/dept")
public class DeptController extends BaseController {
	
	@Autowired
	private DeptService deptService;

	@RequestMapping(value = "/dept-list")
    public String getDeptList(HttpServletRequest request, Model model) throws JSONException {
		model.addAttribute("deptList", deptService.findAll());
		return "forward:/dept/dept-list.jsp";
    }

	@RequestMapping(value = "/delete", produces = { "application/json;charset=UTF-8" })
    @ResponseBody
	public Map<String, Object> deleteDept(HttpServletRequest request, Model model, Integer id) throws Exception {
		Map<String, Object> data = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		boolean flag = deptService.deleteById(id);
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

    @RequestMapping(value = "/dept-add")
	public String addMod(HttpServletRequest request, @ModelAttribute("dept") Dept dept) throws InterruptedException {
		System.out.println("Dept: " + dept.toString());
		System.out.println("HttpServletRequest: " + request.getParameter("desc"));
		System.out.println();
		//System.out.println(desc);
		boolean flag = deptService.save(dept); 
		if (flag) {
			OperateLog operateLog = new OperateLog();
			operateLog.setWorker(SecurityUtils.getSubject().getPrincipal() == null ? ""
					: SecurityUtils.getSubject().getPrincipal().toString());
			operateLog.setCreatetime(new Date());
			operateLog.setOperateLog("部门保存成功:" + dept.getName());
			operateLogService.insert(operateLog);
		}
		return "redirect:/dept/dept-list";
	}

	@RequestMapping(value = "/dept-update")
	public String updateMod(HttpServletRequest request, Dept dept)
			throws InterruptedException {
		boolean flag = deptService.update(dept); 
		if (flag) {
			OperateLog operateLog = new OperateLog();
			operateLog.setWorker(SecurityUtils.getSubject().getPrincipal() == null ? ""
					: SecurityUtils.getSubject().getPrincipal().toString());
			operateLog.setCreatetime(new Date());
			operateLog.setOperateLog("部门更新:" + dept.getName());
			operateLogService.insert(operateLog);
		}
		return "redirect:/dept/dept-list";
	}

    @RequestMapping(value = "/dept-add-show")
	public String addModShow(HttpServletRequest request, Model model) {
		return "forward:/dept/dept-add-show.jsp";
	}

    @RequestMapping(value = "/dept-edit-show")
	public String updateModShow(HttpServletRequest request, Integer id, Model model) {
		Dept dept = deptService.findDeptById(id);
		model.addAttribute("id", dept.getId());
		model.addAttribute("name", dept.getName());
		model.addAttribute("desc", dept.getDesc());
		return "forward:/dept/dept-edit-show.jsp";
	}
}
