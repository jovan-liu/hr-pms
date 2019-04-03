package com.lzh.hr.pms.dao;

import java.util.List;

import com.lzh.hr.pms.entity.Role;

public interface RoleDao {
	/**
	 * 查询所有角色
	 *
	 * @return
	 */
	public List<Role> findList();

	/**
	 * 根据管理员id查询所有角色
	 *
	 * @param accountId
	 * @return
	 */
	public List<Role> findListByAccountId(int accountId);

	/**
	 * 查询不是所属管理员的其他角色
	 *
	 * @param accountId
	 */
	public List<Role> findListNotAccountId(int accountId);

	/**
	 * 根据角色id删除
	 *
	 * @param roleId
	 * @return
	 */
	public Boolean deleteRoleByRoleId(int roleId);

	/**
	 * 根据角色名称查询角色信息
	 *
	 * @param roleName
	 * @return
	 */
	public Role findByRoleName(String roleName);

	/**
	 *
	 * @param role
	 * @return
	 */
	public Boolean insert(Role role);

	/**
	 *
	 * @param roleId
	 * @return
	 */
	public Role findById(int roleId);

	/**
	 *
	 * @param role
	 * @return
	 */
	public Boolean update(Role role);
}
