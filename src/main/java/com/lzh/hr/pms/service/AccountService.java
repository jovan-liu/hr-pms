package com.lzh.hr.pms.service;

import java.util.List;

import com.lzh.hr.pms.entity.Account;

public interface AccountService {
	/**
	 * 查找所有管理员信息
	 *
	 * @return
	 */
	public List<Account> findAccount();

	/**
	 * 保存账户信息
	 *
	 * @param account
	 * @param roles
	 * @return
	 */
	public boolean saveAccount(Account account, String roles);

	/**
	 * 删除账户信息
	 *
	 * @param accountId
	 * @return
	 */
	public boolean delAccount(int accountId);

	/**
	 * 更新账户信息
	 *
	 * @param account
	 * @param roles
	 * @return
	 */
	public boolean updateAccount(Account account, String roles);

	/**
	 * 根据Id查找账户
	 *
	 * @param accountId
	 * @return
	 */
	public Account findAccountById(Integer accountId);

	/**
	 * 根据用户名查找账户
	 *
	 * @param accountId
	 * @return
	 */
	public Account findAccountByUsername(String username);

	/**
	 * 校验账户信息
	 *
	 * @param account
	 * @return
	 */
	public boolean validAccount(Account account);

	/**
	 * 更改密码
	 *
	 * @param account
	 * @return
	 */
	public boolean changePassword(Account account);

}
