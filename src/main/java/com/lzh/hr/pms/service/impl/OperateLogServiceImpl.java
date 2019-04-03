package com.lzh.hr.pms.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lzh.hr.pms.dao.OperateLogDao;
import com.lzh.hr.pms.entity.OperateLog;
import com.lzh.hr.pms.entity.OperateLogInfo;
import com.lzh.hr.pms.response.DataVo;
import com.lzh.hr.pms.response.Page;
import com.lzh.hr.pms.service.OperateLogService;

@Service("operateLogService")
public class OperateLogServiceImpl implements OperateLogService {

	private static final Logger LOG = LoggerFactory.getLogger(OperateLogServiceImpl.class);

	@Autowired
	private OperateLogDao operateLogDao;

	public OperateLog insert(OperateLog log) {
		operateLogDao.insert(log);
		return log;
	}

	public Page<OperateLog> findOperateLogByPage(OperateLogInfo operateLogInfo, Integer pageNumber, Integer pageSize) {
		if (pageNumber == null) {
			pageNumber = 1;
		}
		if (pageSize == null) {
			pageSize = 20;
		}
		OperateLogInfo queryParam = new OperateLogInfo();
		if (queryParam != null) {
			queryParam.setWorker(operateLogInfo.getWorker());
			queryParam.setOperateLog(operateLogInfo.getOperateLog());
			queryParam.setOperateStartTime(operateLogInfo.getOperateStartTime());
			queryParam.setOperateEndTime(operateLogInfo.getOperateEndTime());
		}
		Long start = new Long(pageSize * (pageNumber - 1));
		List<OperateLog> lst = operateLogDao.findOperateLog(queryParam, start, pageSize);
		Long count = operateLogDao.countOperateLog(queryParam);
		Page<OperateLog> operateLogPage = new Page<OperateLog>();
		operateLogPage.setPageNumber(pageNumber);
		operateLogPage.setPageSize(pageSize);
		operateLogPage.setTotalPage(count % pageSize == 0 ? (count / pageSize) : (count / pageSize + 1));
		operateLogPage.setTotalRow(count);
		operateLogPage.setPageList(lst);
		return operateLogPage;
	}

	public void batchInsert(String ids, String worker, String operateType, String tableName) {
		String[] idArrays = ids.split(",");
		try {
			for (String s : idArrays) {
				OperateLog ol = new OperateLog();
				ol.setWorker(worker);
				ol.setCreatetime(new Date());
				JSONObject operateLog = new JSONObject();
				operateLog.put("operateType", operateType);
				operateLog.put("table", tableName);
				operateLog.put("id", s);
				ol.setOperateLog(operateLog.toString());
				operateLogDao.insert(ol);
			}
		} catch (JSONException e) {
			LOG.error(e.getMessage(), e);
		}
	}

	public Map<String, List<DataVo>> getVerifyData(String beginTime, String endTime) {
		List<OperateLog> list = operateLogDao.findAll(beginTime, endTime);
		Map<String, Map<String, Map<Integer, Integer>>> map = new HashMap<String, Map<String, Map<Integer, Integer>>>();
		Map<String, List<DataVo>> returnMap = new HashMap<String, List<DataVo>>();
		try {
			for (OperateLog log : list) {
				String operateDetail = log.getOperateLog();
				JSONObject object = new JSONObject(operateDetail);
				String operateType = object.getString("operateType");
				Integer hour = log.getCreatetime().getHours() + 1;
				if (!map.containsKey(operateType)) {
					Map<String, Map<Integer, Integer>> valueMap = new HashMap<String, Map<Integer, Integer>>();
					Map<Integer, Integer> innerMap = new HashMap<Integer, Integer>();
					innerMap.put(hour, 1);
					valueMap.put(log.getWorker(), innerMap);
					map.put(operateType, valueMap);

				} else {
					Map<String, Map<Integer, Integer>> valueMap = map.get(operateType);
					if (!valueMap.containsKey(log.getWorker())) {
						Map<Integer, Integer> innerMap = new HashMap<Integer, Integer>();
						innerMap.put(hour, 1);
						valueMap.put(log.getWorker(), innerMap);
					} else {
						Map<Integer, Integer> innerMap = valueMap.get(log.getWorker());
						if (!innerMap.containsKey(hour)) {
							innerMap.put(hour, 1);
						} else {
							innerMap.put(hour, innerMap.get(hour) + 1);
						}
					}
				}
			}

			for (Entry<String, Map<String, Map<Integer, Integer>>> rootEntry : map.entrySet()) {
				String key = rootEntry.getKey();
				Map<String, Map<Integer, Integer>> rootValue = rootEntry.getValue();
				List<DataVo> returnList = new ArrayList<DataVo>();
				for (Entry<String, Map<Integer, Integer>> entry : rootValue.entrySet()) {
					Map<Integer, Integer> value = entry.getValue();
					DataVo vo = new DataVo();
					vo.setLabel(entry.getKey());
					List<Integer[]> dataList = new ArrayList<Integer[]>();
					vo.setData(dataList);
					// 如果时间小于8点，那么统计为8点这个时间段的
					Integer lowEight = 0;
					// 如果时间大于19点，那么统计为19点这个时间段的
					Integer highNineteen = 0;
					for (Entry<Integer, Integer> valueEntry : value.entrySet()) {
						Integer time = valueEntry.getKey();
						Integer timeValue = valueEntry.getValue();
						if (time <= 8) {
							lowEight += timeValue;
						} else if (time <= 18) {
							dataList.add(new Integer[] { time, timeValue });
						} else {
							highNineteen += timeValue;
						}
					}
					dataList.add(new Integer[] { 8, lowEight });
					dataList.add(new Integer[] { 19, highNineteen });
					List<Integer> eightToNineteen = new ArrayList(Arrays.asList(9, 10, 11, 12, 13, 14, 15, 16, 17, 18));
					eightToNineteen.removeAll(value.keySet());
					for (Integer left : eightToNineteen) {
						dataList.add(new Integer[] { left, 0 });
					}
					Collections.sort(dataList, new Comparator<Integer[]>() {
						public int compare(Integer[] first, Integer[] secend) {
							return first[0] - secend[0];
						}

					});
					returnList.add(vo);
				}
				returnMap.put(key, returnList);
			}
		} catch (JSONException e) {
			LOG.error(e.getMessage(), e);
		}
		return returnMap;
	}

}
