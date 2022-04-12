package kr.happyjob.study.pcm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.pcm.model.PcmOrderListModel;

public interface PcmOrderListService {

	/** 발주 내역 목록 조회 */
	//listPurchaseOrder 가 쿼리문 ID가 됌.
	public List<PcmOrderListModel> listPurchaseOrder(Map<String, Object> paramMap) throws Exception;

	/** 발주 내역 목록 총건 수 조회 */
	public int totalCount(Map<String, Object> paramMap) throws Exception;

	/** 발주 내역 한건 조회 */
	public PcmOrderListModel pcmOrderOne(Map<String, Object> paramMap)throws Exception;;

}
