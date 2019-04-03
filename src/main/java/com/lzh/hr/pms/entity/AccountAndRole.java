package com.lzh.hr.pms.entity;

import java.util.Date;

public class AccountAndRole {
	/**
	 * 对应Account类accountId
	 */
	private Integer accountId;
	/**
	 * 角色Id
	 */
	private Integer roleId;
	/**
	 * 创建时间
	 */
	private Date createTime;

	public AccountAndRole(Integer accountId, Integer roleId, Date createTime) {
		this.accountId = accountId;
		this.roleId = roleId;
		this.createTime = createTime;
	}

	public AccountAndRole() {

	}

	public Integer getAccountId() {
		return accountId;
	}

	public void setAccountId(Integer accountId) {
		this.accountId = accountId;
	}

	public Integer getRoleId() {
		return roleId;
	}

	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
}
