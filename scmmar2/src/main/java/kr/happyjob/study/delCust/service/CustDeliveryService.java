package kr.happyjob.study.delCust.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.delCust.model.CustDeliveryModel;

public interface CustDeliveryService {
	
	/** 목록 조회 */
	public List<CustDeliveryModel> listCustDelivery(Map<String, Object> paramMap) throws Exception;
	
	/** 목록 카운트 조회 */
	public int countCustDelivery(Map<String, Object> paramMap) throws Exception;
	
	/** 상세 조회 */
	public CustDeliveryModel selectCustDelivery(Map<String, Object> paramMap) throws Exception;

}
