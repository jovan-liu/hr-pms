package com.lzh.hr.pms.service;

import java.util.List;

import com.lzh.hr.pms.entity.Role;

public interface RoleService {
	/**
	 *
	 * @return
	 */
	public List<Role> findRole();

	/**
	 *
	 * @param accountId
	 * @return
	 */
	public List<Role> findRoleByAccountId(Integer accountId);

	/**
	 *
	 * @param role
	 * @param perms
	 * @return
	 */
	public boolean addRole(Role role, String perms);

	/**
	 *
	 * @param roleId
	 * @return
	 */
	public Role getRoleById(Integer roleId);

	/**
	 *
	 * @param role
	 * @param perms
	 * @return
	 */
	public boolean updateRole(Role role, String perms);

	/**
	 *
	 * @param roleId
	 * @return
	 */
	public boolean delRole(Integer roleId);

	/**
	 *
	 * @param role
	 * @return
	 */
	public boolean validRole(Role role);
}
