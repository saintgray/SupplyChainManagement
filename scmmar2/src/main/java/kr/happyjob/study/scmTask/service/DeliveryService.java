package kr.happyjob.study.scmTask.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scmTask.model.DeliveryModel;

public interface DeliveryService {
	
	/** 목록 조회 */
	public List<DeliveryModel> listDelivery(Map<String, Object> paramMap) throws Exception;
	
	/** 목록 카운트 조회 */
	public Integer countListDelivery(Map<String, Object> paramMap) throws Exception;
	
	/** 상세 조회 */
	public DeliveryModel selectDelivery(Map<String, Object> paramMap) throws Exception;

}
