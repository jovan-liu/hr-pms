package com.lzh.hr.pms.entity;

import java.util.Date;

public class OperateLogInfo {
	private long id;
	private String worker;
	private String operateLog;
	private Date createtime;
	private String operateStartTime;
	private String operateEndTime;

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

	public String getOperateStartTime() {
		return operateStartTime;
	}

	public void setOperateStartTime(String operateStartTime) {
		this.operateStartTime = operateStartTime;
	}

	public String getOperateEndTime() {
		return operateEndTime;
	}

	public void setOperateEndTime(String operateEndTime) {
		this.operateEndTime = operateEndTime;
	}

}
