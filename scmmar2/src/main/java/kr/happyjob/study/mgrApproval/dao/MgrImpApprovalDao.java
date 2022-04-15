package kr.happyjob.study.mgrApproval.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.mgrApproval.model.MgrImpApprovalModel;

public interface MgrImpApprovalDao {

	/** 발주 목록 조회 */
	//listImpApproval 가 쿼리문 ID가 됌.
	public List<MgrImpApprovalModel> listImpApproval(Map<String, Object> paramMap);
	
	/** 발주 목록 카운트 조회 */
	public int countListImpApproval(Map<String, Object> paramMap);
	
	/** 임원 승인 여부 수정 */
	public int updateImpMgrYn(Map<String, Object> paramMap);
	
	/** 발주 상세 목록 조회	 */
	public List<MgrImpApprovalModel> listDtImpApproval(Map<String, Object> paramMap);
	
	/** 발주 상세 목록 카운트 조회	 */
	public int countListImpApprovalDt(Map<String, Object> paramMap);
	
	/** 재고정보 insert */
	public int insertStockCnt(Map<String, Object> paramMap);
}
