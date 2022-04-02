package com.nexacro.sample.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.nexacro.sample.service.PcAdminStatisticsService;
import com.nexacro.sample.service.impl.ibatis.PcAdminStatisticsDAO;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("pcAdminStatisticsService")
public class PcAdminStatisticsServiceImpl extends EgovAbstractServiceImpl implements PcAdminStatisticsService{
	@Resource(name = "pcAdminStatisticsDAO")
	private PcAdminStatisticsDAO pcAdminStatisticsDAO;
	
	@Override
	public List<Map<String, Object>> pcAdminStatisticsList(Map<String, Object> statisticsList) {
		System.out.println("ServiceImpl : pcAdminStatisticsList 호출 성공");
		return pcAdminStatisticsDAO.pcAdminStatisticsList(statisticsList);
	}
	
	@Override
	public List<Map<Integer, Object>> userAndOrderCnt(Map<String, Object>statisticsList) {
		// TODO Auto-generated method stub
		return pcAdminStatisticsDAO.userAndOrderCnt(statisticsList);
	}
}
