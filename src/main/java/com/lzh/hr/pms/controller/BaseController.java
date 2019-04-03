package com.lzh.hr.pms.controller;

import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lzh.hr.pms.dao.PermissionDao;
import com.lzh.hr.pms.entity.Permission;
import com.lzh.hr.pms.service.OperateLogService;

@Controller
@RequestMapping("/base")
public class BaseController {

	private static final Logger LOG = LoggerFactory.getLogger(BaseController.class);

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	public Permission permission;
	@Autowired
	public PermissionDao permissionDao;
	@Autowired
	public OperateLogService operateLogService;

	/**
	 * 判断是否重要操作
	 *
	 * @param permission
	 * @return
	 */
	public boolean isImpower(String permission) {
		Permission result = permissionDao.findPermByPermission(permission);
		if (result.getImpower() != null && result.getImpower() == 1) {
			return true;
		}
		return false;
	}

	/**
	 * 校验授权码是否正确
	 */
	@RequestMapping(value = "/base-power-check")
	public String powerCheck(HttpServletRequest request, Model model, String acceptcode, String fromUrl,
			String permission, String powercode, String rtxnumber) {
		if (powercode != null && powercode.equals(acceptcode)) {
			request.getSession().setAttribute(permission, "true");
			return "redirect:" + fromUrl;
		}
		model.addAttribute("errorMsg", "授权码错误");
		model.addAttribute("powercode", powercode);
		model.addAttribute("fromUrl", fromUrl);
		model.addAttribute("rtxnumber", rtxnumber);
		model.addAttribute("permission", permission);
		return "forward:/base/base-power-show.jsp";
	}

	public void setPermission(Permission permission) {
		this.permission = permission;
	}

	public void setPermissionDao(PermissionDao permissionDao) {
		this.permissionDao = permissionDao;
	}

}
