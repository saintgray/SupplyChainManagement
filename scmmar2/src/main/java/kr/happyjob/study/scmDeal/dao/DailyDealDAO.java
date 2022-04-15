package kr.happyjob.study.scmDeal.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scmDeal.model.DailyDeal;

public interface DailyDealDAO {
	
	/** 수주 목록 조회 */
	public List<DailyDeal> selectList(Map<String, Object> paramMap) throws Exception;
	
	/** 수주 목록 총개수 */
	public int selectListTotal(Map<String, Object> paramMap) throws Exception;
	
	/** 수주 단건 조회 */
	public DailyDeal selectOne(Map<String, Object> paramMap) throws Exception;

	/** 배송담당 직원 목록 조회 */
	public List<DailyDeal> selectEmployeeList(Map<String, Object> paramMap) throws Exception;
	
	/** 1) 창고 목록 조회 */
	public List<DailyDeal> selectWhList(Map<String, Object> paramMap) throws Exception;
	
	/** 2) 창고별 제품 목록 조회 */
	public List<DailyDeal> selectPdList(Map<String, Object> paramMap) throws Exception;
	
	/** 3) 장고별 제품별 재소수량 조회 */
	public int selectStCount(Map<String, Object> paramMap) throws Exception;
	
	/** 배송 정보 저장 */
	public int insertDelivery(Map<String, Object> paramMap) throws Exception;
	
	/** 재고 정보 수정 */
	public int updateStock(Map<String, Object> paramMap) throws Exception;
	
	/** 납품회사 목록 조회 */
	public List<DailyDeal> selectComList(Map<String, Object> paramMap) throws Exception;
	
	/** 납품 정보 저장 */
	public int insertImport(Map<String, Object> paramMap) throws Exception;
	
	/** 납품 디테일 정보 저장 */
	public int insertImportDetail(Map<String, Object> paramMap) throws Exception;
	
}
