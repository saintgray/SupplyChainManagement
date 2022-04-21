package kr.happyjob.study.scm.orders.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.orders.dao.whInventoryFormDao;
import kr.happyjob.study.scm.orders.model.whInventoryFormModel;
import kr.happyjob.study.scm.orders.model.whcntModel;
import kr.happyjob.study.scm.sales.dao.SalesManageDao;

@Service
public class whInventoryFormServiceImpl implements whInventoryFormService {

	
	
	@Autowired
	whInventoryFormDao wiDao;
	@Autowired
	SalesManageDao smDao;
	
	@Override
	public List<whInventoryFormModel> whlist(Map<String, Object> paramMap) throws Exception {
		List<whInventoryFormModel> whlist = wiDao.whlist(paramMap);
		return whlist;
	}

	@Override
	public List<whcntModel> getStockState(String idx) throws Exception {
		List<whcntModel> detail = wiDao.getStockState(idx);
		return detail;
	}
	
	@Override
	public int total(Map<String, Object> paramMap) throws Exception {
		return wiDao.total(paramMap);
	}

	@Override
	public List<whcntModel> getValidWareHouse(String pur_idx,String purchaserUserType) {
		
		// 해당 구매/발주 고유번호를 참조하는 발주상세 또는 구매상세 의 모든 고유번호 값을 가져온다.
		List<String> list = null;
		list=smDao.selectAllPurchaseInfoByIdx(pur_idx,purchaserUserType);
		for(int i=0; i<list.size(); i++){
			list.set(i, list.get(i).substring(0,list.get(i).lastIndexOf(",")));
		}
		
		List<whcntModel> whList=null;
		whList=wiDao.getValidWareHouseInfo(list);

		return whList;
	}
	
}
