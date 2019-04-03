package com.lzh.hr.pms.entity;

public class Role {
	/**
	 * 角色id
	 */
	private Integer id;
	/**
	 * 角色名称
	 */
	private String roleName;
	/**
	 * 描述
	 */
	private String description;
	/**
	 * 是否存在
	 */
	private boolean exist;

	public Role(Integer id, String roleName, String description) {
		this.id = id;
		this.roleName = roleName;
		this.description = description;
	}

	public Role() {

	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
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

		Role role = (Role) o;

		if (id != null ? !id.equals(role.id) : role.id != null) {
			return false;
		}

		return true;
	}

	@Override
	public int hashCode() {
		return id != null ? id.hashCode() : 0;
	}
}
