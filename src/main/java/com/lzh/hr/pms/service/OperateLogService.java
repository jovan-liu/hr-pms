package com.lzh.hr.pms.service;

import java.util.List;
import java.util.Map;

import com.lzh.hr.pms.entity.OperateLog;
import com.lzh.hr.pms.entity.OperateLogInfo;
import com.lzh.hr.pms.response.DataVo;
import com.lzh.hr.pms.response.Page;

public interface OperateLogService {
	/**
	 * 插入操作日志
	 *
	 * @param operateLog
	 * @return
	 */
	public OperateLog insert(OperateLog operateLog);

	/**
	 * 批量插入操作日志
	 *
	 * @param ids
	 * @param worker
	 * @param operateType
	 * @param tableName
	 */
	public void batchInsert(String ids, String worker, String operateType, String tableName);

	/**
	 * 根据时间段获取日志信息
	 *
	 * @param beginTime
	 * @param endTime
	 * @return
	 * @throws Exception
	 */
	public Map<String, List<DataVo>> getVerifyData(String beginTime, String endTime);

	/**
	 * 根据条件查询日志记录
	 */
	public Page<OperateLog> findOperateLogByPage(OperateLogInfo operateLogInfo, Integer pageNumber, Integer pageSize);
}
