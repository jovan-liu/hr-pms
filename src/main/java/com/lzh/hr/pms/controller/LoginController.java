package com.lzh.hr.pms.controller;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.realm.Realm;
import org.apache.shiro.realm.jdbc.JdbcRealm;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lzh.hr.pms.dao.AccountDao;
import com.lzh.hr.pms.entity.Account;
import com.lzh.hr.pms.entity.OperateLog;
import com.lzh.hr.pms.service.AccountService;
import com.lzh.hr.pms.service.OperateLogService;

@Controller
@RequestMapping("/account")
public class LoginController {

	protected static Logger LOG = LoggerFactory.getLogger(LoginController.class);

	@Autowired
	private DefaultWebSecurityManager securityManager;

	@Autowired
	private OperateLogService operateLogService;

	@Autowired
	private AccountService accountService;

	@Autowired
	private AccountDao accountDao;

	@Autowired
	private JdbcRealm sqlRealm;// mysql realm

	/**
	 * 用户登陆
	 *
	 * @param username
	 * @param password
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/login")
	public String execute(HttpServletRequest request, String username, String password, Model model) {
		try {
			if (username == null || password == null) {
				return "forward:/account/login.jsp";
			}
			Collection<Realm> realms = new ArrayList<Realm>();
			realms.add(sqlRealm);
			securityManager.setRealms(realms);
			SecurityUtils.setSecurityManager(securityManager);
			Subject currentUser = SecurityUtils.getSubject();
			Account account = accountDao.getAccountByUsername(username);
			if (password.equals(account.getPassword())) {
				UsernamePasswordToken token = new UsernamePasswordToken(username, password);
				token.setRememberMe(true);
				currentUser.login(token);
			}
			request.getSession().setAttribute("userId", account.getAccountId());
			request.getSession().setAttribute("username", username);
			OperateLog ol = new OperateLog();
			ol.setWorker(username);
			ol.setCreatetime(new Date());
			ol.setOperateLog(username + "登录");
			operateLogService.insert(ol);
			return "redirect:/nyx/index";
		} catch (Exception e) {
			model.addAttribute("errorMsg", "账号密码错误");
			LOG.error(e.getMessage(), e);
		}
		return "forward:/account/login.jsp";
	}

	@RequestMapping(value = "/check", method = RequestMethod.GET, produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public Map<String, Object> check(HttpServletRequest request, String username, String password) {

		Map<String, Object> data = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (StringUtils.isEmpty(username) || StringUtils.isEmpty(password)) {
				data.put("code", "1001");
			}
			Collection<Realm> realms = new ArrayList<Realm>();
			realms.add(sqlRealm);
			securityManager.setRealms(realms);
			SecurityUtils.setSecurityManager(securityManager);
			Subject currentUser = SecurityUtils.getSubject();
			Account account = accountDao.getAccountByUsername(username);
			if (password.equals(account.getPassword())) {
				UsernamePasswordToken token = new UsernamePasswordToken(username, password);
				token.setRememberMe(true);
				currentUser.login(token);
				OperateLog ol = new OperateLog();
				ol.setWorker(username);
				ol.setCreatetime(new Date());
				ol.setOperateLog(username + "登录");
				operateLogService.insert(ol);
				data.put("code", "1000");
			} else {
				data.put("code", "1001");
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return data;
	}
}
