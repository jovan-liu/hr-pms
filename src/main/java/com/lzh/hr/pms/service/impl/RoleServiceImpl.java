package com.lzh.hr.pms.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lzh.hr.pms.dao.AccountAndRoleDao;
import com.lzh.hr.pms.dao.RoleAndPermDao;
import com.lzh.hr.pms.dao.RoleDao;
import com.lzh.hr.pms.entity.Role;
import com.lzh.hr.pms.entity.RoleAndPerm;
import com.lzh.hr.pms.service.RoleService;

@Service("roleService")
public class RoleServiceImpl implements RoleService {
	@Autowired
	private RoleDao roleDao;
	@Autowired
	private RoleAndPermDao roleAndPermDao;
	@Autowired
	private AccountAndRoleDao accountAndRoleDao;

	public List<Role> findRole() {
		return roleDao.findList();
	}

	public List<Role> findRoleByAccountId(Integer accountId) {
		return roleDao.findListByAccountId(accountId);
	}

	public boolean addRole(Role role, String perms) {
		boolean flag = roleDao.insert(role);
		if (!flag) {
			return false;
		}
		if (perms != null && !perms.equals("null")) {
			String[] permArr = perms.split(",");
			RoleAndPerm rap = null;
			for (String perm : permArr) {
				rap = new RoleAndPerm(role.getId(), Integer.parseInt(perm), new Date());
				flag = roleAndPermDao.insert(rap);
			}
		}
		return flag;
	}

	public Role getRoleById(Integer roleId) {
		return roleDao.findById(roleId);
	}

	public boolean updateRole(Role role, String perms) {
		boolean flag = roleDao.update(role);
		if (!flag) {
			return false;
		}
		roleAndPermDao.deleteRoleAndPermByRoleId(role.getId());
		if (perms != null && !perms.equals("null")) {
			String[] permArr = perms.split(",");
			RoleAndPerm rap = null;
			for (String perm : permArr) {
				rap = new RoleAndPerm(role.getId(), Integer.parseInt(perm), new Date());
				flag = roleAndPermDao.insert(rap);
			}
		}
		return flag;
	}

	public boolean delRole(Integer roleId) {
		roleAndPermDao.deleteRoleAndPermByRoleId(roleId);
		accountAndRoleDao.deleteByRoleId(roleId);
		return roleDao.deleteRoleByRoleId(roleId);
	}

	public boolean validRole(Role role) {
		return roleDao.findByRoleName(role.getRoleName()) == null;
	}

	public void setRoleDao(RoleDao roleDao) {
		this.roleDao = roleDao;
	}

	public void setRoleAndPermDao(RoleAndPermDao roleAndPermDao) {
		this.roleAndPermDao = roleAndPermDao;
	}

	public void setAccountAndRoleDao(AccountAndRoleDao accountAndRoleDao) {
		this.accountAndRoleDao = accountAndRoleDao;
	}
}
