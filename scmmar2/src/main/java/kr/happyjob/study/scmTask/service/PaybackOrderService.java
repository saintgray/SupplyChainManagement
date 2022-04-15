package kr.happyjob.study.scmTask.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scmTask.model.PaybackOrderModel;

public interface PaybackOrderService {

	
	/** 고객정보 목록 조회 */
	public List<PaybackOrderModel> listPaybackOrder(Map<String, Object> paramMap) throws Exception;
	
	/** 고객정보 목록 카운트 조회 */
	public int countListPaybackOrder(Map<String, Object> paramMap) throws Exception;
	
	/* 반품승인여부 업데이트 */
	public int updateOdryn(PaybackOrderModel paybackOrderModel) throws Exception;
}
