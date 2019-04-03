package com.lzh.hr.pms.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lzh.hr.pms.dao.PermissionDao;
import com.lzh.hr.pms.dao.RoleAndPermDao;
import com.lzh.hr.pms.entity.Permission;
import com.lzh.hr.pms.service.PermissionService;

@Service("permissionService")
public class PermissionServiceImpl implements PermissionService {

	@Autowired
	private PermissionDao permissionDao;
	@Autowired
	private RoleAndPermDao roleAndPermDao;

	public List<Permission> findPermByRoleId(Integer roleId) {
		return permissionDao.getListByRoleId(roleId);
	}

	public List<Permission> findAllPrem() {
		return permissionDao.getList();
	}

	public List<String> getAllPermName() {
		List<Permission> permList = permissionDao.getList();
		List<String> nameList = new ArrayList<String>();
		for (Permission permission : permList) {
			nameList.add(permission.getPermission());
		}
		return nameList;
	}

	public boolean addPermission(Permission perm) {
		perm.setCreateTime(new Date());
		return permissionDao.insert(perm);
	}

	public Permission getPermById(Integer permId) {
		return permissionDao.findById(permId);
	}

	public boolean delPermission(Integer permId) {
		roleAndPermDao.deleteRoleAndPermByPermId(permId);
		return permissionDao.deleteById(permId);
	}

	public boolean validPermission(Permission perm) {
		return permissionDao.findPermByPermission(perm.getPermission()) == null;
	}

	public boolean updatePerm(Permission permission) {
		return permissionDao.update(permission);
	}

	public void setPermissionDao(PermissionDao permissionDao) {
		this.permissionDao = permissionDao;
	}

	public void setRoleAndPermDao(RoleAndPermDao roleAndPermDao) {
		this.roleAndPermDao = roleAndPermDao;
	}
}
