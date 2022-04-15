package kr.happyjob.study.crtPayback.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.crtPayback.model.CrtOrderHistoryModel;
import kr.happyjob.study.crtPayback.model.OrderDetailModel;
import kr.happyjob.study.crtPayback.model.OrderModel;

public interface CrtOrderHistoryService {

	List<OrderModel> listOrderHistory(Map<String, Object> paramMap);

	int countlistOrderHistory(Map<String, Object> paramMap);

	List<OrderDetailModel> listorderHistoryDtl(Map<String, Object> paramMap);

	int countlistOrderHistoryDtl(Map<String, Object> paramMap);

	List<Map<String, Object>> listBankList();

	int updateReturnYn(Map<String, Object> resultMap);

	int saveReturnInfo(Map<String, Object> resultMap);

	int insertReturnInfo(Map<String, Object> returnInfoMap);

	int insertClientReturn(Map<String, Object> resultMap);

	
	
	
}
