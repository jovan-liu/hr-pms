package com.lzh.hr.pms.entity;

import java.util.Date;

public class Permission {
	/**
	 * 权限Id
	 */
	private Integer id;
	/**
	 * 权限Url
	 */
	private String permission;
	/**
	 * 描述
	 */
	private String description;
	/**
	 * 创建时间
	 */
	private Date CreateTime;

	/**
	 * 是否需授权
	 */
	private Integer impower;

	/**
	 * 授权人RTX账号
	 */
	private String rtxnumber;

	/**
	 * 是否存在，辅助字段
	 */
	private boolean exist;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getPermission() {
		return permission;
	}

	public void setPermission(String permission) {
		this.permission = permission;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Date getCreateTime() {
		return CreateTime;
	}

	public void setCreateTime(Date createTime) {
		CreateTime = createTime;
	}

	public boolean isExist() {
		return exist;
	}

	public void setExist(boolean exist) {
		this.exist = exist;
	}

	@Override
	public boolean equals(Object o) {
		if (this == o) {
			return true;
		}
		if (o == null || getClass() != o.getClass()) {
			return false;
		}

		Permission that = (Permission) o;

		if (!id.equals(that.id)) {
			return false;
		}

		return true;
	}

	@Override
	public int hashCode() {
		return id.hashCode();
	}

	public Integer getImpower() {
		return impower;
	}

	public void setImpower(Integer impower) {
		this.impower = impower;
	}

	public String getRtxnumber() {
		return rtxnumber;
	}

	public void setRtxnumber(String rtxnumber) {
		this.rtxnumber = rtxnumber;
	}

}
