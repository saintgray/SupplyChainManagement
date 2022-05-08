package kr.happyjob.study.shipping.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.shipping.model.RefundModel;


public interface RefundService {

	/** 반품지시서 목록 조회 */
	public List<RefundModel> listRefund(Map<String, Object> paramMap)throws Exception;
	
	/** 반품지시서 목록 카운트 */
	public int countListRefund(Map<String, Object> paramMap)throws Exception;
	
	// 반품지시서 상세 페이지
	public RefundModel  detailRefund(Map<String, Object> paramMap) throws Exception;
	
	// 반품 상태 변경
	public int updateDeliReturnDir(Map<String, Object> paramMap) throws Exception;
	
	// 반품 재고 추가
	public int updateStockReduce(Map<String, Object> paramMap) throws Exception;
	
	// 반품에 관한 배송 상태변경
	public int updateDelidelivDir(Map<String, Object> paramMap) throws Exception;
	
	// 반품시 재고 입출력내용 변경
	public void insertDeparturehis(Map<String, Object> paramMap) throws Exception;
	
}
