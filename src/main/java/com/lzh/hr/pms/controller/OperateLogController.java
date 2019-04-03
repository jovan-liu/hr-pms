package com.lzh.hr.pms.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lzh.hr.pms.entity.OperateLog;
import com.lzh.hr.pms.entity.OperateLogInfo;
import com.lzh.hr.pms.response.Page;
import com.lzh.hr.pms.service.OperateLogService;

@Controller
@RequestMapping("/operatelog")
@Scope("session")
public class OperateLogController extends BaseController {

	private static final Logger LOG = LoggerFactory.getLogger(OperateLogController.class);

	@Autowired
	private OperateLogService operateLogService;

	@RequestMapping(value = "/operatelog-list")
	public String operatelogList(Model model, Integer pageNumber, String worker, String operateLog, String beginDate,
			String endDate, HttpServletRequest request) {
		if (pageNumber == null) {
			pageNumber = 1;
		}
		OperateLogInfo queryParam = new OperateLogInfo();
		if (worker != null && worker.length() > 0) {
			queryParam.setWorker(worker);
		}
		if (operateLog != null && operateLog.length() > 0) {
			queryParam.setOperateLog(operateLog);
		}
		if (beginDate != null && beginDate.length() > 0) {
			queryParam.setOperateStartTime(beginDate + " 00:00:00");
			if (endDate != null && endDate.length() > 0) {
				queryParam.setOperateEndTime(endDate + " 23:59:59");
			} else {
				queryParam.setOperateEndTime(beginDate + " 23:59:59");
			}
		}
		Page<OperateLog> operatelogList = operateLogService.findOperateLogByPage(queryParam, pageNumber, 20);
		model.addAttribute("pageNumber", pageNumber);
		model.addAttribute("operatelogList", operatelogList);
		model.addAttribute("worker", worker);
		model.addAttribute("operateLog", operateLog);
		model.addAttribute("beginDate", beginDate);
		model.addAttribute("endDate", endDate);
		return "forward:/operatelog/operatelog-list.jsp";
	}
}
