package com.lzh.hr.pms.dao;

import java.util.List;

import com.lzh.hr.pms.entity.Account;

public interface AccountDao {
	/**
	 * 查找所有管理员
	 *
	 * @return
	 */
	public List<Account> findList();

	/**
	 * 根据用户名查找
	 *
	 * @param username
	 * @return
	 */
	public Account findByUsername(String username);

	public Account getAccountByUsername(String username);

	/**
	 * 插入管理员
	 *
	 * @param account
	 * @return
	 */
	public Boolean insert(Account account);

	/**
	 * 根据主键删除
	 *
	 * @param id
	 * @return
	 */
	public Boolean deleteById(int id);

	/**
	 *
	 * @param account
	 * @return
	 */
	public Boolean update(Account account);

	/**
	 *
	 * @param accountId
	 * @return
	 */
	public Account findById(Integer accountId);

}
