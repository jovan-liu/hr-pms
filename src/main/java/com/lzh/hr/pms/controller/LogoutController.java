package com.lzh.hr.pms.controller;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/account")
public class LogoutController {

    /**
     * 登出
     * @return
     */
    @RequestMapping(value = "/logout")
    public String logout() {
	Subject subject = SecurityUtils.getSubject();
	subject.logout();
	return "forward:/account/login.jsp";
    }
}
