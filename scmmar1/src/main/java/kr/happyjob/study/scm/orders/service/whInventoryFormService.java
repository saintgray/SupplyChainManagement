package kr.happyjob.study.scm.orders.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.orders.model.whInventoryFormModel;
import kr.happyjob.study.scm.orders.model.whcntModel;

public interface whInventoryFormService {

	// list 조회
	public List<whInventoryFormModel> whlist(Map<String, Object> paramMap) throws Exception;
	// 창고재고현황 조회
	public List<whcntModel> getStockState(String idx) throws Exception;
	// 총 값
	public int total(Map<String, Object> paramMap) throws Exception;
	
	// 구매한 상품당 유효한 창고리스트 가져오기
	public List<whcntModel> getValidWareHouse(String pur_idx,String purchaserUserType);
	
}
