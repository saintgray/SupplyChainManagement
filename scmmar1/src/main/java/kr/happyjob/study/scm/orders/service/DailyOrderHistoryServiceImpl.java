package kr.happyjob.study.scm.orders.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.orders.dao.DailyOrderHistoryDao;
import kr.happyjob.study.scm.orders.dao.DirDao;
import kr.happyjob.study.scm.orders.model.CompModel;
import kr.happyjob.study.scm.orders.model.DailyOrderHistoryModel;
import kr.happyjob.study.scm.orders.model.WorkOrderModel;
import kr.happyjob.study.scm.orders.model.warehouseModel;
import kr.happyjob.study.scm.user.dao.UserInfoDao;
import kr.happyjob.study.scm.user.service.UserInfoService;

@Service
public class DailyOrderHistoryServiceImpl implements DailyOrderHistoryService{

	@Autowired
	DailyOrderHistoryDao dailyorderhistorydao;
	@Autowired
	DirDao dirDao;
	
	@Override
	public List<DailyOrderHistoryModel> listdailyOrderHistory(Map<String, Object> paramMap) throws Exception {

		List<DailyOrderHistoryModel> listdailyOrderHistory = dailyorderhistorydao.listdailyOrderHistory(paramMap);
		
		return listdailyOrderHistory;
	}

	@Override
	public int total(Map<String, Object> paramMap) throws Exception {
		return dailyorderhistorydao.total(paramMap);
	}

	@Override
	public List<WorkOrderModel> onedailyOrderHistory(Map<String, Object> paramMap) throws Exception {
		
		// 이 주문의 type 추출
		paramMap.put("type",(int)dirDao.getPurchaseType(paramMap.get("pur_id").toString()));
		
		
		List<WorkOrderModel> onedailyOrderHistory = dailyorderhistorydao.onedailyOrderHistory(paramMap);
		return onedailyOrderHistory;
	}

	@Override
	public List<warehouseModel> warehouse() throws Exception {
		List<warehouseModel> warehouse = dailyorderhistorydao.warehouse();
		return warehouse;
	}

	@Override
	public warehouseModel whcnt(Map<String, Object> paramMap) throws Exception {
		warehouseModel whcnt = dailyorderhistorydao.whcnt(paramMap);
		return whcnt;
	}

	@Override
	public List<CompModel> comp() throws Exception {
		List<CompModel> comp = dailyorderhistorydao.comp();
		return comp;
	}

	@Override
	public int insertcom1(Map<String, Object> paramMap) throws Exception {
		
		return dailyorderhistorydao.insertcom1(paramMap);
	}

	@Override
	public int insertcom2(Map<String, Object> paramMap) throws Exception {
		
		return dailyorderhistorydao.insertcom2(paramMap);
	}

	@Override
	public int insertreturn(Map<String, Object> paramMap) throws Exception {
		return dailyorderhistorydao.insertreturn(paramMap);
	}

	@Override
	public int insertdel(Map<String, Object> paramMap) throws Exception {
		return dailyorderhistorydao.insertdel(paramMap);
	}

	@Override
	public DailyOrderHistoryModel comf(Map<String, Object> paramMap) throws Exception {
		DailyOrderHistoryModel comf = dailyorderhistorydao.comf(paramMap);
		return comf;
	}
	
	@Override
	public DailyOrderHistoryModel come(Map<String, Object> paramMap) throws Exception {
		DailyOrderHistoryModel come = dailyorderhistorydao.come(paramMap);
		return come;
	}
	
	
	
	
	
	
}