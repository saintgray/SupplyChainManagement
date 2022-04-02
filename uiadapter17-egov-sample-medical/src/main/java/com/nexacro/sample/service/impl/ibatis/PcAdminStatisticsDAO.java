package com.nexacro.sample.service.impl.ibatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.nexacro.spring.dao.ibatis.NexacroIbatisAbstractDAO;

@Repository("pcAdminStatisticsDAO")
public class PcAdminStatisticsDAO extends NexacroIbatisAbstractDAO {
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> pcAdminStatisticsList(Map<String, Object> statisticsList){
		System.out.println("DAO : List호출 성공");
		return (List<Map<String, Object>>) list("statistics.statisticsList", statisticsList);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<Integer, Object>> userAndOrderCnt(Map<String, Object> statisticsList){
		return (List<Map<Integer, Object>>) list("statistics.statisticsCnt", statisticsList);
	}
}
