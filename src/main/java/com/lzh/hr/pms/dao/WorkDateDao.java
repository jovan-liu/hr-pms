package com.lzh.hr.pms.dao;

public interface WorkDateDao {

	/**
	 * 查询两个日期之前的节假日有多少天
	 * SELECT COUNT(w.id) FROM work_day w 
	 * WHERE w.work_day BETWEEN '2019-01-01' AND '2019-01-31';
	 * @param beginDate 开始日期
	 * @param endDate 结束日期
	 * @return
	 */
	Long countWorkDate(String beginDate, String endDate);
}
