package kr.happyjob.study.scmTask.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scmTask.model.PaybackOrderModel;

public interface PaybackOrderDao {

	
	/** 고객정보 목록 조회 */
	//listPaybackOrder 가 쿼리문 ID가 됌.
	public List<PaybackOrderModel> listPaybackOrder(Map<String, Object> paramMap);
	
	/** 고객정보 목록 카운트 조회 */
	public int countListPaybackOrder(Map<String, Object> paramMap);
	
	/* 반품승인여부 업데이트 */
	public int updateOdryn(PaybackOrderModel paybackOrderModel);
}
