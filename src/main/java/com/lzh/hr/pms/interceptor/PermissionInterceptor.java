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

		menuList.put("account-list", 6);
		menuList.put("account-role-list", 7);
		menuList.put("account-perm-list", 8);

		menuList.put("category-list", 10);
		menuList.put("tag-list", 11);

		menuList.put("item-list", 12);
		menuList.put("book-list", 13);
		menuList.put("post-list", 14);
		menuList.put("user-list", 15);

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
