package kr.happyjob.study.delCust.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.delCust.model.CustDeliveryModel;

public interface CustDeliveryDao {
	
	/** 목록 조회 */
	//listCustDelivery 가 쿼리문 ID가 됌.
	public List<CustDeliveryModel> listCustDelivery(Map<String, Object> paramMap);
	
	/** 목록 카운트 조회 */
	public int countCustDelivery(Map<String, Object> paramMap);
	
	/** 상세 조회 */
	public CustDeliveryModel selectCustDelivery(Map<String, Object> paramMap);

}
