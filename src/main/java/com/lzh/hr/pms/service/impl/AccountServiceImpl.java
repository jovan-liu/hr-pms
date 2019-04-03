package com.lzh.hr.pms.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lzh.hr.pms.dao.AccountAndRoleDao;
import com.lzh.hr.pms.dao.AccountDao;
import com.lzh.hr.pms.dao.RoleDao;
import com.lzh.hr.pms.entity.Account;
import com.lzh.hr.pms.entity.AccountAndRole;
import com.lzh.hr.pms.entity.Role;
import com.lzh.hr.pms.service.AccountService;
import com.lzh.hr.pms.util.MD5Utils;

@Service("accountService")
public class AccountServiceImpl implements AccountService {

	@Autowired
	private AccountDao accountDao;

	@Autowired
	private RoleDao roleDao;

	@Autowired
	private AccountAndRoleDao accountAndRoleDao;

	public List<Account> findAccount() {
		return accountDao.findList();
	}

	public boolean saveAccount(Account account, String role) {
		account.setCreateTime(new Date());
		account.setStatus(1);
		account.setPassword(MD5Utils.encodePassword());// 随机生成密码
		boolean flag = accountDao.insert(account);
		if (!role.equals("null")) {
			Role result = roleDao.findByRoleName(role);
			Integer roleId = result.getId();
			AccountAndRole accountAndRole = null;
			accountAndRole = new AccountAndRole(account.getAccountId(), roleId, new Date());
			accountAndRoleDao.insert(accountAndRole);
		}
		return flag;
	}

	public boolean delAccount(int accountId) {
		accountAndRoleDao.deleteByAccountId(accountId);
		boolean flag = accountDao.deleteById(accountId);
		return flag;
	}

	public boolean updateAccount(Account account, String roles) {
		boolean flag = true;
		accountAndRoleDao.deleteByAccountId(account.getAccountId());
		if (roles != null && !roles.equals("null")) {
			String[] roleIds = roles.split(",");
			AccountAndRole aar = null;
			for (String roleId : roleIds) {
				aar = new AccountAndRole(account.getAccountId(), Integer.parseInt(roleId), new Date());
				accountAndRoleDao.insert(aar);
			}
		}
		return flag;
	}

	public Account findAccountById(Integer accountId) {
		return accountDao.findById(accountId);
	}

	public Account findAccountByUsername(String username) {
		return accountDao.findByUsername(username);
	}

	public boolean validAccount(Account account) {
		return accountDao.findByUsername(account.getUsername()) == null;
	}

	public boolean changePassword(Account account) {
		return accountDao.update(account);
	}

}
