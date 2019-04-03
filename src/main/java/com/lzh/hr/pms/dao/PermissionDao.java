package com.lzh.hr.pms.dao;

import java.util.List;

import com.lzh.hr.pms.entity.Permission;

public interface PermissionDao {
	/**
	 * 根据角色Id获取权限列表
	 *
	 * @param roleId
	 *            角色Id
	 * @return
	 */
	public List<Permission> getListByRoleId(int roleId);

	/**
	 * 根据permId删除权限记录
	 *
	 * @param permId
	 *            权限Id
	 * @return
	 */
	public Boolean deleteById(int permId);

	/**
	 * 获取所有权限信息
	 *
	 * @return
	 */
	public List<Permission> getList();

	/**
	 * 根据权限URl获取权限信息
	 *
	 * @return
	 */
	public Permission findPermByPermission(String permission);

	/**
	 *
	 * @param perm
	 * @return
	 */
	public Boolean insert(Permission perm);

	/**
	 *
	 * @param id
	 * @return
	 */
	public Permission findById(int id);

	/**
	 *
	 * @param permission
	 * @return
	 */
	public Boolean update(Permission permission);
}
