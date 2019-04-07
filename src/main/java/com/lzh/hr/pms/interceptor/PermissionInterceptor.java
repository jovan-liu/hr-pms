package com.lzh.hr.pms.interceptor;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 * 2018-08-15
 * 
 * @author jovan.liu
 */
public class PermissionInterceptor extends HandlerInterceptorAdapter {

	public static final Map<String, Integer> menuList = new HashMap<String, Integer>();

	static {

		// 超级管理员权限
		menuList.put("account-list", 6);
		menuList.put("account-role-list", 7);
		menuList.put("account-perm-list", 8);

		// 人事权限 部门AND员工
		menuList.put("dept-list", 10);
		menuList.put("emp-list", 11);
		menuList.put("emp-attendance-list", 12);
		menuList.put("emp-ot-list", 13);
		menuList.put("emp-leave-list", 14);
		menuList.put("emp-salary-list", 15);

		// 普通员工权限
		menuList.put("attendance-list", 20);
		menuList.put("ot-list", 21);
		menuList.put("leave-list", 22);
		menuList.put("salary-list", 23);

		menuList.put("operatelog-list", 100);

	}

	private Integer menu;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		String url = request.getRequestURI().toString().split(";")[0];
		int index = url.lastIndexOf("/");
		String actionUrl = url.substring(index + 1);
		Integer menu = menuList.get(actionUrl);
		if (menu != null) {
			request.setAttribute("menu", menu);
		} else {
			menu = menuList.get(actionUrl.split(".action")[0]);
			if (menu != null) {
				request.setAttribute("menu", menu);
			}
		}
		request.setAttribute("titleName", "HR-PMS");
		if (menuList.containsKey(actionUrl)) {
			return super.preHandle(request, response, handler);
		} else {
			return super.preHandle(request, response, handler);
		}
	}

	public void setMenu(Integer menu) {
		this.menu = menu;
	}
}
