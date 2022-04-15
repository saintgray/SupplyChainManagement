package kr.happyjob.study.scmDeal.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scmDeal.model.WarehouseInfo;

public interface WarehouseInfoDAO {

	/** 창고 목록 조회 */
	public List<WarehouseInfo> selectList(Map<String, Object> paramMap) throws Exception;
	
	/** 창고 목록 총개수 */
	public int selectListTotal(Map<String, Object> paramMap) throws Exception;

	/** 창고별 상세목록 */
	public List<WarehouseInfo> selectDetailList(Map<String, Object> paramMap) throws Exception;
	
	/** 창고별 상세목록 총개수 */
	public int selectDetailTotal(Map<String, Object> paramMap) throws Exception;

}
