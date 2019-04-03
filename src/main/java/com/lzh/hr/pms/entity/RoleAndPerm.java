package com.lzh.hr.pms.entity;

import java.util.Date;

/**
 * 2018-08-15
 * 
 * @author jovan.liu
 */
public class RoleAndPerm {
	/**
	 * 角色Id
	 */
	private Integer roleId;
	/**
	 * 权限Id
	 */
	private Integer permId;
	/**
	 * 创建时间
	 */
	private Date createTime;

	public RoleAndPerm(Integer roleId, Integer permId, Date createTime) {
		super();
		this.roleId = roleId;
		this.permId = permId;
		this.createTime = createTime;
	}

	public RoleAndPerm() {

	}

	public Integer getRoleId() {
		return roleId;
	}

	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}

	public Integer getPermId() {
		return permId;
	}

	public void setPermId(Integer permId) {
		this.permId = permId;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
}
