package com.lzh.hr.pms.service;

import java.util.List;

import com.lzh.hr.pms.entity.Permission;

public interface PermissionService {
	/**
	 *
	 * @param roleId
	 * @return
	 */
	public List<Permission> findPermByRoleId(Integer roleId);

	/**
	 *
	 * @return
	 */
	public List<Permission> findAllPrem();

	/**
	 *
	 * @return
	 */
	public List<String> getAllPermName();

	/**
	 *
	 * @param perm
	 * @return
	 */
	public boolean addPermission(Permission perm);

	/**
	 *
	 * @param permId
	 * @return
	 */
	public Permission getPermById(Integer permId);

	/**
	 *
	 * @param permId
	 * @return
	 */
	public boolean delPermission(Integer permId);

	/**
	 *
	 * @param perm
	 * @return
	 */
	public boolean validPermission(Permission perm);

	/**
	 *
	 * @param permission
	 * @return
	 */
	public boolean updatePerm(Permission permission);
}
