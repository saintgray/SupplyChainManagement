package kr.happyjob.study.scmTask.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scmTask.model.DeliveryModel;

public interface DeliveryDao {
	
	/** 목록 조회 */
	//listDelivery 가 쿼리문 ID가 됌.
	public List<DeliveryModel> listDelivery(Map<String, Object> paramMap);
	
	/** 목록 카운트 조회 */
	public Integer countListDelivery(Map<String, Object> paramMap);
	
	/** 상세 조회 */
	public DeliveryModel selectDelivery(Map<String, Object> paramMap);

}
