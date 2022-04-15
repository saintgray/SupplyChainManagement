package kr.happyjob.study.scmDeal.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scmDeal.model.DailyDeal;

public interface DaliyDealService {
	
	/** 수주 목록 조회 */
	public List<DailyDeal> getList(Map<String, Object> paramMap) throws Exception;
	
	/** 수주 목록 총개수 */
	public int getTotalCount(Map<String, Object> paramMap) throws Exception;

	/** 수주 단건 조회 */
	public DailyDeal getOne(Map<String, Object> paramMap) throws Exception;
	
	/** 배송담당 직원 목록 조회 */
	public List<DailyDeal> getDeliveryMen(Map<String, Object> paramMap) throws Exception;

	/** 1) 창고 목록 조회 */
	public List<DailyDeal> getWarhouses(Map<String, Object> paramMap) throws Exception;
	
	/** 2) 창고별 제품 목록 조회 */
	public List<DailyDeal> getProductList(Map<String, Object> paramMap) throws Exception;
	
	/** 3) 장고별 제품별 재고수량 조회 */
	public int getStTotalCount(Map<String, Object> paramMap) throws Exception;
	
	/** 배송 정보 저장 */
	public int saveDeliveryInfo(Map<String, Object> paramMap) throws Exception;
	
	/** 재고 정보 수정 */
	public int modifyStockInfo(Map<String, Object> paramMap) throws Exception;

	/** 납품회사 목록 조회 */
	public List<DailyDeal> getComList(Map<String, Object> paramMap) throws Exception;
	
	/** 납품 정보 저장 */
	public int saveImport(Map<String, Object> paramMap) throws Exception;
	
	/** 납품 디테일 정보 저장 */
	public int saveImportDetai(Map<String, Object> paramMap) throws Exception;	

}
