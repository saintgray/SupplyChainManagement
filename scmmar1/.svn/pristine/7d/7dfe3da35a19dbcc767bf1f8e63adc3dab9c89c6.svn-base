package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.dao.dailyOrderHistoryDao;
import kr.happyjob.study.scm.model.dailyOrderHistoryModel;

@Service
public class dailyOrderHistoryServiceImpl implements dailyOrderHistoryService{

	@Autowired
	dailyOrderHistoryDao dailyorderhistorydao;
	
	@Override
	public List<dailyOrderHistoryModel> listdailyOrderHistory(Map<String, Object> paramMap) throws Exception {

		List<dailyOrderHistoryModel> listdailyOrderHistory = dailyorderhistorydao.listdailyOrderHistory(paramMap);
		
		return listdailyOrderHistory;
	}

	@Override
	public int total() throws Exception {
		return dailyorderhistorydao.total();
	}
	
}
