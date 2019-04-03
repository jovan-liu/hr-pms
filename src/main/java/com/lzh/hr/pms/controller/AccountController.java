package com.lzh.hr.pms.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lzh.hr.pms.entity.Account;
import com.lzh.hr.pms.entity.OperateLog;
import com.lzh.hr.pms.entity.Permission;
import com.lzh.hr.pms.entity.Role;
import com.lzh.hr.pms.entity.SecretUser;
import com.lzh.hr.pms.service.AccountService;
import com.lzh.hr.pms.service.OperateLogService;
import com.lzh.hr.pms.service.PermissionService;
import com.lzh.hr.pms.service.RoleService;

@Controller
@RequestMapping("/account")
public class AccountController {

	private static final Logger LOG = LoggerFactory.getLogger(AccountController.class);

	@Autowired
	private AccountService accountService;
	@Autowired
	private RoleService roleService;
	@Autowired
	private PermissionService permissionService;
	@Autowired
	private OperateLogService operateLogService;

	/**
	 * 权限管理/用户列表
	 *
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/account-list")
	public String accountList(Model model) {

		List<Account> accountList = accountService.findAccount();
		for (Account acc : accountList) {
			List<Role> rolesList = roleService.findRole();
			List<Role> existRolesList = roleService.findRoleByAccountId(acc.getAccountId());
			for (Role role : rolesList) {
				role.setExist(existRolesList.contains(role));
			}
			acc.setRoleList(rolesList);
		}
		List<SecretUser> secretUsers = null;
		model.addAttribute("secretUserList", secretUsers);
		model.addAttribute("accountList", accountList);
		return "forward:/account/account-list.jsp";
	}

	/**
	 * 权限管理/角色列表
	 *
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/account-role-list")
	public String roleList(Model model) {
		List<Role> rolesList = roleService.findRole();
		model.addAttribute("rolesList", rolesList);
		return "forward:/account/account-role.jsp";
	}

	/**
	 * 账户添加页面渲染展示
	 *
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/account-add-show")
	public String toAddAccount(Model model) {
		List<Role> rolesList = roleService.findRole();
		List<SecretUser> secretUsers = null;
		model.addAttribute("secretUserList", secretUsers);
		model.addAttribute("rolesList", rolesList);
		return "forward:/account/account-add.jsp";
	}

	/**
	 * 权限管理/权限列表
	 *
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/account-perm-list")
	public String permList(Model model) {
		List<Permission> permList = permissionService.findAllPrem();
		model.addAttribute("permList", permList);
		return "forward:/account/account-perm.jsp";
	}

	/**
	 * 账户删除操作
	 *
	 * @param accountId
	 * @return
	 */
	@RequestMapping(value = "/account-del-operate", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public Map<String, Object> delAccount(HttpSession session, int accountId) {
		Map<String, Object> data = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		boolean flag = accountService.delAccount(accountId);
		OperateLog operateLog = new OperateLog();

		operateLog.setWorker(SecurityUtils.getSubject().getPrincipal() == null ? ""
				: SecurityUtils.getSubject().getPrincipal().toString());
		operateLog.setCreatetime(new Date());
		operateLog.setOperateLog("删除用户 accountID:" + accountId);
		operateLogService.insert(operateLog);
		map.put("result", flag);
		data.put("data", map);
		data.put("status", "success");
		return data;
	}

	/**
	 * 账户修改操作
	 *
	 * @param roles
	 * @param account
	 * @param beginTime
	 * @param endTime
	 * @return
	 */
	@RequestMapping(value = "/account-edit-operate", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public Map<String, Object> editUser(HttpSession session, String roles, Account account, String beginTime,
			String endTime) {
		Map<String, Object> data = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		boolean flag = accountService.updateAccount(account, roles);
		OperateLog operateLog = new OperateLog();

		operateLog.setWorker(SecurityUtils.getSubject().getPrincipal() == null ? ""
				: SecurityUtils.getSubject().getPrincipal().toString());
		operateLog.setCreatetime(new Date());
		operateLog.setOperateLog("修改用户ID" + account.getAccountId() + "的角色为：" + roles);
		operateLogService.insert(operateLog);
		map.put("result", flag);
		data.put("data", map);
		data.put("status", "success");
		return data;
	}

	/**
	 * 账户删除操作页面渲染
	 *
	 * @return
	 */
	@RequestMapping(value = "/account-del-show")
	public String showDelAccount() {
		return "forward:/account/account-del-show.jsp";
	}

	/**
	 * 账户修改页面渲染
	 *
	 * @param accountId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/account-edit-show")
	public String showEditAccount(Integer accountId, Model model) {
		List<Role> rolesList = roleService.findRole();
		List<Role> existRolesList = roleService.findRoleByAccountId(accountId);
		for (Role role : rolesList) {
			role.setExist(existRolesList.contains(role));
		}
		List<SecretUser> secretUsers = null;
		model.addAttribute("secretUserList", secretUsers);

		Account account = accountService.findAccountById(accountId);
		model.addAttribute("account", account);
		model.addAttribute("rolesList", rolesList);
		return "forward:/account/account-edit-show.jsp";
	}

	/**
	 * 角色添加页面渲染
	 *
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/account-role-add-show")
	public String addRoleUI(Model model) {
		List<Permission> permList = permissionService.findAllPrem();
		model.addAttribute("permList", permList);
		return "forward:/account/account-role-add-show.jsp";
	}

	/**
	 * 角色添加操作
	 *
	 * @param perms
	 * @param role
	 * @return
	 */
	@RequestMapping(value = "/account-role-add-operate", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public Map<String, Object> addRole(HttpSession session, Integer accountId, String perms, Role role) {
		Map<String, Object> data = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		boolean flag = roleService.addRole(role, perms);
		OperateLog operateLog = new OperateLog();

		operateLog.setWorker(SecurityUtils.getSubject().getPrincipal() == null ? ""
				: SecurityUtils.getSubject().getPrincipal().toString());
		operateLog.setCreatetime(new Date());
		operateLog.setOperateLog("新增角色：" + role.getRoleName() + "(" + role.getDescription() + ")");
		operateLogService.insert(operateLog);
		map.put("result", flag);
		data.put("data", map);
		data.put("status", "success");
		return data;
	}

	@RequestMapping(value = "/account-change-password-show")
	public String changePasswordShow(Model model, Integer accountId) {
		model.addAttribute("accountId", accountId);
		return "forward:/account/account-change-password-show.jsp";
	}

	@RequestMapping(value = "/account-change-password", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public Map<String, Object> password(HttpSession session, Integer accountId, String oldPassword, String newPassword,
			String newPasswordAgain) {
		Map<String, Object> data = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		boolean flag = true;
		Account account = accountService.findAccountById(accountId);
		if (oldPassword != null && account.getPassword().equals(oldPassword)) {
			if (newPassword.equals(newPasswordAgain)) {
				account.setPassword(newPassword);
				accountService.changePassword(account);
			}
		} else {
			flag = false;
		}
		OperateLog operateLog = new OperateLog();
		operateLog.setWorker(SecurityUtils.getSubject().getPrincipal() == null ? ""
				: SecurityUtils.getSubject().getPrincipal().toString());
		operateLog.setCreatetime(new Date());
		operateLog.setOperateLog("用户：" + accountId + "修改密码");
		operateLogService.insert(operateLog);
		map.put("result", flag);
		data.put("data", map);
		data.put("status", "success");
		return data;
	}

	/**
	 * 角色修改页面渲染
	 *
	 * @param roleId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/account-role-edit-show")
	public String toEditRole(Integer roleId, Model model) {
		List<Permission> permList = permissionService.findAllPrem();

		List<Permission> existPermList = permissionService.findPermByRoleId(roleId);
		for (Permission perm : permList) {
			perm.setExist(existPermList.contains(perm));
		}
		Role role = roleService.getRoleById(roleId);
		model.addAttribute("role", role);
		model.addAttribute("permList", permList);
		return "forward:/account/account-role-edit-show.jsp";
	}

	/**
	 * 角色删除页面渲染
	 *
	 * @param model
	 * @param roleId
	 * @return
	 */
	@RequestMapping(value = "/account-role-del-show")
	public String toDelRole(Model model, int roleId) {
		model.addAttribute("roleId", roleId);
		return "forward:/account/account-role-del-show.jsp";
	}

	/**
	 * 角色修改操作
	 *
	 * @param perms
	 * @param role
	 * @return
	 */
	@RequestMapping(value = "/account-role-edit-operate")
	@ResponseBody
	public Map<String, Object> editRole(HttpSession session, String perms, Role role) {
		Map<String, Object> data = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		boolean flag = roleService.updateRole(role, perms);
		OperateLog operateLog = new OperateLog();

		operateLog.setWorker(SecurityUtils.getSubject().getPrincipal() == null ? ""
				: SecurityUtils.getSubject().getPrincipal().toString());
		operateLog.setCreatetime(new Date());
		operateLog.setOperateLog("修改角色：" + role.getRoleName() + "(" + role.getDescription() + ")");
		operateLogService.insert(operateLog);
		map.put("result", flag);
		data.put("data", map);
		data.put("status", "success");
		return data;
	}

	/**
	 * 角色删除操作
	 *
	 * @param roleId
	 * @return
	 */
	@RequestMapping(value = "/account-role-del-operate", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public Map<String, Object> delRole(HttpSession session, Integer roleId) {
		Map<String, Object> data = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		boolean flag = roleService.delRole(roleId);
		OperateLog operateLog = new OperateLog();

		operateLog.setWorker(SecurityUtils.getSubject().getPrincipal() == null ? ""
				: SecurityUtils.getSubject().getPrincipal().toString());
		operateLog.setCreatetime(new Date());
		operateLog.setOperateLog("删除角色：roleId" + roleId);
		operateLogService.insert(operateLog);
		map.put("result", flag);
		data.put("data", map);
		data.put("status", "success");
		return data;
	}

	/**
	 * 权限添加页面渲染
	 *
	 * @return
	 */
	@RequestMapping(value = "/account-perm-add-show")
	public String detailPerm() {
		return "forward:/account/account-perm-add-show.jsp";
	}

	/**
	 * 权限添加操作
	 *
	 * @param permission
	 * @return
	 */
	@RequestMapping(value = "/account-perm-add-operate", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public Map<String, Object> addPerm(HttpSession session, Permission permission) {
		Map<String, Object> data = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		boolean flag = permissionService.addPermission(permission);
		OperateLog operateLog = new OperateLog();

		operateLog.setWorker(SecurityUtils.getSubject().getPrincipal() == null ? ""
				: SecurityUtils.getSubject().getPrincipal().toString());
		operateLog.setCreatetime(new Date());
		operateLog.setOperateLog("添加权限：" + permission.getPermission() + "　　描述:" + permission.getDescription());
		operateLogService.insert(operateLog);
		// 如果权限添加成功，将该权限赋给admin角色
		if (flag) {
			List<Permission> permList = permissionService.findAllPrem();
			String perms = "";
			for (Permission perm : permList) {
				perms = perms + perm.getId() + ",";
			}
			Role admin = roleService.getRoleById(1);
			roleService.updateRole(admin, perms);
		}
		map.put("result", flag);
		data.put("data", map);
		data.put("status", "success");
		return data;
	}

	/**
	 * 权限修改页面渲染
	 *
	 * @param permId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/account-perm-edit-show")
	public String toEditPerm(Integer permId, Model model) {
		Permission permission = permissionService.getPermById(permId);
		model.addAttribute("permission", permission);
		return "forward:/account/account-perm-edit-show.jsp";
	}

	/**
	 * 权限修改操作
	 *
	 * @param permission
	 * @return
	 */
	@RequestMapping(value = "/account-perm-edit-operate", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public Map<String, Object> editPerm(HttpSession session, Permission permission) {
		Map<String, Object> data = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		boolean flag = permissionService.updatePerm(permission);
		OperateLog operateLog = new OperateLog();

		operateLog.setWorker(SecurityUtils.getSubject().getPrincipal() == null ? ""
				: SecurityUtils.getSubject().getPrincipal().toString());
		operateLog.setCreatetime(new Date());
		operateLog.setOperateLog("修改权限：" + permission.getPermission() + "　　描述:" + permission.getDescription());
		operateLogService.insert(operateLog);
		map.put("result", flag);
		data.put("data", map);
		data.put("status", "success");
		return data;
	}

	/**
	 * 权限删除页面渲染
	 *
	 * @param permId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/account-perm-del-show")
	public String toDelPerm(Integer permId, Model model) {
		model.addAttribute("permId", permId);
		return "forward:/account/account-perm-del-show.jsp";
	}

	/**
	 * 权限删除操作
	 *
	 * @param permId
	 * @return
	 */
	@RequestMapping(value = "/account-perm-del-operate", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public Map<String, Object> delPerm(HttpSession session, Integer permId) {
		Map<String, Object> data = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		boolean flag = permissionService.delPermission(permId);
		OperateLog operateLog = new OperateLog();

		operateLog.setWorker(SecurityUtils.getSubject().getPrincipal() == null ? ""
				: SecurityUtils.getSubject().getPrincipal().toString());
		operateLog.setCreatetime(new Date());
		operateLog.setOperateLog("删除权限ID：" + permId);
		operateLogService.insert(operateLog);
		map.put("result", flag);
		data.put("data", map);
		data.put("status", "success");
		return data;
	}

	/**
	 * 账户添加输入的用户名重复校验
	 *
	 * @param account
	 * @return
	 */
	@RequestMapping(value = "/account-add-validate", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public Map<String, Object> validAccount(Account account) {
		Map<String, Object> data = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		boolean flag = accountService.validAccount(account);
		map.put("result", flag);
		data.put("status", "success");
		data.put("data", map);
		return data;
	}

	/**
	 * 添加的角色名称重复校验
	 *
	 * @param role
	 * @return
	 */
	@RequestMapping(value = "/account-role-validate", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public Map<String, Object> validRole(Role role) {
		Map<String, Object> data = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		boolean flag = roleService.validRole(role);
		map.put("result", flag);
		data.put("data", map);
		data.put("status", "success");
		return data;
	}

	/**
	 * 权限url重复校验
	 *
	 * @param permission
	 * @return
	 */
	@RequestMapping(value = "/account-perm-validate", produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public Map<String, Object> validPerm(Permission permission) {
		Map<String, Object> data = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		boolean flag = permissionService.validPermission(permission);
		map.put("result", flag);
		data.put("data", map);
		data.put("status", "success");
		return data;
	}

}
