package kr.happyjob.study.shipping.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.shipping.model.ShippingModel;

public interface ShippingService {

	/** 배송지시서 목록 조회 */
	public List<ShippingModel> listDeliOrder(Map<String, Object> paramMap) throws Exception;
	
	/** 배송지시서 목록 카운트 조회 */
	public int countListDeliOrder(Map<String, Object> paramMap) throws Exception;
	
	/** 배송지시서 단건 상세 조회 selectOne */
	public ShippingModel selectDeliOrder(Map<String, Object> paramMap) throws Exception;
	
	/** 배송지시서 배송상태 변경 */
	public int updateDeliOrder(Map<String, Object> paramMap) throws Exception;
	
	/**창고 수량 감소*/
	public int updateStockReduce(Map<String, Object> paramMap) throws Exception;
	
	/**재고입출내역 insert*/
	public int insertDeparturehis(Map<String, Object> paramMap) throws Exception;
	
	/** 타임스탬프 테스트 */
	public String testSelect() throws Exception;
}
