package kr.happyjob.study.scmStandard.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scmStandard.model.WhInfoModel;
import kr.happyjob.study.system.model.ComnCodUtilModel;

public interface WhInfoDao {
	
	/** 창고정보 목록 조회 */
	//listWarehouseInfo 가 쿼리문 ID가 됌.
	public List<WhInfoModel> listWarehouseInfo(Map<String, Object> paramMap);
	
	/** 창고정보 목록 카운트 조회 */
	public int countListWarehouseInfo(Map<String, Object> paramMap);
	
	/** 창고정보 단건 조회 */
	public WhInfoModel selectWarehouseInfo(Map<String, Object> paramMap);
	
	/** 창고정보 저장 */
	public int insertWarehouseInfo(Map<String, Object> paramMap);
	
	/** 창고정보 수정 */
	public int updateWarehouseInfo(Map<String, Object> paramMap);

	/** 창고정보 삭제 */
	public int deleteWarehouseInfo(Map<String, Object> paramMap);
	
	/** 창고담당자 목록 조회 */
	public List<ComnCodUtilModel> mgrnmList (Map<String, Object> paramMap);

}
