package kr.happyjob.study.crtPayback.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.crtPayback.dao.CrtOrderHistoryDao;
import kr.happyjob.study.crtPayback.model.CrtOrderHistoryModel;
import kr.happyjob.study.crtPayback.model.OrderDetailModel;
import kr.happyjob.study.crtPayback.model.OrderModel;

@Service
public class CrtOrderHistoryServiceImpl implements CrtOrderHistoryService {

	@Autowired
	CrtOrderHistoryDao crtOrderHistoryDao;
	
	@Override
	public List<OrderModel> listOrderHistory(Map<String, Object> paramMap) {
		return crtOrderHistoryDao.listOrderHistory(paramMap);
	}

	@Override
	public int countlistOrderHistory(Map<String, Object> paramMap) {
		return crtOrderHistoryDao.countlistOrderHistory(paramMap);
	}

	@Override
	public List<OrderDetailModel> listorderHistoryDtl(Map<String, Object> paramMap) {
		return crtOrderHistoryDao.listorderHistoryDtl(paramMap);
	}

	@Override
	public int countlistOrderHistoryDtl(Map<String, Object> paramMap) {
		return crtOrderHistoryDao.countlistOrderHistoryDtl(paramMap);
	}

	@Override
	public List<Map<String, Object>> listBankList() {
		return crtOrderHistoryDao.listBankList();
	}

	@Override
	public int updateReturnYn(Map<String, Object> resultMap) {
		return crtOrderHistoryDao.updateReturnYn(resultMap);
	}

	@Override
	public int saveReturnInfo(Map<String, Object> resultMap) {
		return crtOrderHistoryDao.saveReturnInfo(resultMap);
	}

	@Override
	public int insertReturnInfo(Map<String, Object> returnInfoMap) {
		return crtOrderHistoryDao.insertReturnInfo(returnInfoMap);
	}

	@Override
	public int insertClientReturn(Map<String, Object> resultMap) {
		return crtOrderHistoryDao.insertClientReturn(resultMap);
	}

	
	
}
