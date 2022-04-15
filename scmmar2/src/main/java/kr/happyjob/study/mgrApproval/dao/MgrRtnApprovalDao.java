package kr.happyjob.study.mgrApproval.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.mgrApproval.model.MgrRtnApprovalModel;

public interface MgrRtnApprovalDao {

	/** 발주 목록 조회 */
	//listImpApproval 가 쿼리문 ID가 됌.
	public List<MgrRtnApprovalModel> listRtnApproval(Map<String, Object> paramMap);
	
	/** 발주 목록 카운트 조회 */
	public int countListRtnApproval(Map<String, Object> paramMap);
	
	/** 임원 승인 여부 수정 */
	public int updateRtnMgrYn(Map<String, Object> paramMap);
}
