package com.nexacro.sample.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nexacro.sample.service.PcAdminStatisticsService;
import com.nexacro.uiadapter17.spring.core.annotation.ParamDataSet;
import com.nexacro.uiadapter17.spring.core.data.NexacroResult;

@Controller
public class PcAdminStatisticsController {
	
	@Autowired
	@Resource(name = "pcAdminStatisticsService")
	private PcAdminStatisticsService pcAdminStatisticsService;
	
	@RequestMapping(value = "/statisticsSearch.do")
	public NexacroResult statisticsSearch(@ParamDataSet(name = "ds_searchDate", required = false) Map<String, Object> statisticsList){
		System.out.println("controller : statisticsSeacrh 호출 성공");
		
		List<Map<String, Object>> adminStatisticsList = pcAdminStatisticsService.pcAdminStatisticsList(statisticsList);
		List<Map<Integer, Object>> userAndOrderCnt = pcAdminStatisticsService.userAndOrderCnt(statisticsList);
		NexacroResult result = new NexacroResult();
		result.addDataSet("ds_statistics", adminStatisticsList);
		result.addDataSet("ds_count", userAndOrderCnt);
		return result;
	}
}
