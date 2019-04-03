package com.lzh.hr.pms.entity;

import java.util.Date;

public class OperateLog {
	private long id;
	private String worker;
	private String operateLog;
	private Date createtime;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getWorker() {
		return worker;
	}

	public void setWorker(String worker) {
		this.worker = worker;
	}

	public String getOperateLog() {
		return operateLog;
	}

	public void setOperateLog(String operateLog) {
		this.operateLog = operateLog;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

}
