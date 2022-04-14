package kr.happyjob.study.shipping.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.shipping.model.RefundModel;


public interface RefundDao {

	/** 반품지시서 목록 조회 */
	public List<RefundModel> listRefund(Map<String, Object> paramMap)throws Exception;
	
	/** 반품지시서 목록 카운트 */
	public int countListRefund(Map<String, Object> paramMap)throws Exception;
}
