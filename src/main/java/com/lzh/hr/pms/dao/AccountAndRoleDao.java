package com.lzh.hr.pms.dao;

import com.lzh.hr.pms.entity.AccountAndRole;

public interface AccountAndRoleDao {
	/**
	 * 根据用户Id删除中间关系表
	 *
	 * @param id
	 * @return
	 */
	public Boolean deleteByAccountId(int id);

	/**
	 * 根据角色Id删除中间关系表
	 *
	 * @param roleId
	 *            角色Id
	 * @return
	 */
	public Boolean deleteByRoleId(int roleId);

	/**
	 *
	 * @param accountAndRole
	 * @return
	 */
	public Boolean insert(AccountAndRole accountAndRole);
}
