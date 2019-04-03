package com.lzh.hr.pms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.lzh.hr.pms.entity.OperateLog;
import com.lzh.hr.pms.entity.OperateLogInfo;

public interface OperateLogDao {
	/**
	 * 查找所有操作日志
	 * 
	 * @param beginTime
	 * @param endTime
	 * @return
	 */
	public List<OperateLog> findAll(String beginTime, String endTime);

	/**
	 * 插入日志
	 * 
	 * @param log
	 * @return
	 */
	public Boolean insert(OperateLog log);

	/**
	 * 获取日志总数
	 */
	public Long countOperateLog(OperateLogInfo param);

	/**
	 * 根据条件查询日志
	 */
	public List<OperateLog> findOperateLog(@Param("param") OperateLogInfo param, @Param("start") Long start, @Param("limit") Integer limit);
}
