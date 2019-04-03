package com.lzh.hr.pms.dao;

import com.lzh.hr.pms.entity.RoleAndPerm;

public interface RoleAndPermDao {
    /**
     * 根据角色id删除role_permisions表数据
     *
     * @param roleId
     * @return
     */
    public Boolean deleteRoleAndPermByRoleId(Integer roleId);

    /**
     * 根据权限id删除数据
     *
     * @param permId
     * @return
     */
    public Boolean deleteRoleAndPermByPermId(Integer permId);

    /**
     *
     * @param rap
     * @return
     */
    public Boolean insert(RoleAndPerm rap);
}
