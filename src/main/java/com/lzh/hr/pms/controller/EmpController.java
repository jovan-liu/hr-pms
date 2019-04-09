package com.lzh.hr.pms.controller;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

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
    	String photo = "";
    	try {
			photo = uploadImg2Oss(request);
			emp.setPhoto(photo);
		} catch (Exception e) {
			e.printStackTrace();
		}
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
    
    public String uploadImg2Oss(HttpServletRequest request) throws Exception {
		String name = "";
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());
		if (multipartResolver.isMultipart(request)) {
		    MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
		    @SuppressWarnings("rawtypes")
		    Iterator iter = multiRequest.getFileNames();
		    while (iter.hasNext()) {
				MultipartFile file = multiRequest.getFile(iter.next().toString());
				if (file.getSize() > 4 * 1024 * 1024) {
					throw new Exception("上传图片大小不能超过4M！");
				}
				if (file.getSize() != 0) {
					String originalFilename = file.getOriginalFilename();
					String substring = originalFilename.substring(originalFilename.lastIndexOf(".")).toLowerCase();
					Random random = new Random();
					name = random.nextInt(10000) + System.currentTimeMillis() + substring;
					try {
						InputStream inputStream = file.getInputStream();
						// 设置数据缓冲
						byte[] bs = new byte[1024 * 2];
						// 读取到的数据长度
						int len;
						// 输出的文件流保存图片至本地
						String filePath = "d:\\upload\\" + name;
						OutputStream os = new FileOutputStream(filePath);
						while ((len = inputStream.read(bs)) != -1) {
							os.write(bs, 0, len);
						}
						os.close();
						inputStream.close();
						System.err.println(filePath);
						return "/upload/" + name;
					} catch (Exception e) {
						throw new Exception("图片上传失败");
					}
				}
		    }
		}
		return name;
	}

	@RequestMapping(value = "/emp-update")
	public String updateMod(HttpServletRequest request, Emp emp, String del2)
			throws InterruptedException {
		if (del2 != null && del2.equals("true")) {
			try {
				String tempImage = uploadImg2Oss(request);
				emp.setPhoto(tempImage);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
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
