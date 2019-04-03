package com.lzh.hr.pms.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("nyx")
public class IndexController {

	@RequestMapping("index")
	public String forwardToIndex() {
		return "forward:/nyx/index.jsp";
	}

}
