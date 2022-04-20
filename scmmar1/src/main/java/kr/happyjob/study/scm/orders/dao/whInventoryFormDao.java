package kr.happyjob.study.scm.orders.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.orders.model.whInventoryFormModel;
import kr.happyjob.study.scm.orders.model.whcntModel;

public interface whInventoryFormDao {

	// list 조회
	public List<whInventoryFormModel> whlist(Map<String, Object> paramMap) throws Exception;
	// 창고재고현황
	public List<whcntModel> getStockState(String idx) throws Exception;
	// 총 값
	public int total(Map<String, Object> paramMap) throws Exception;
}
