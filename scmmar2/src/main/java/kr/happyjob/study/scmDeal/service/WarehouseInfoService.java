package kr.happyjob.study.scmDeal.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scmDeal.model.WarehouseInfo;

public interface WarehouseInfoService {

	/** 창고 목록 조회 */
	public List<WarehouseInfo> getList(Map<String, Object> paramMap) throws Exception;
	
	/** 창고 목록 총개수 */
	public int getTotal(Map<String, Object> paramMap) throws Exception;
	
	/** 창고별 상세목록 */
	public List<WarehouseInfo> getDetail(Map<String, Object> paramMap) throws Exception;
	
	/** 창고별 상세목록 총개수 */
	public int getDetailTotal(Map<String, Object> paramMap) throws Exception;
	
}
