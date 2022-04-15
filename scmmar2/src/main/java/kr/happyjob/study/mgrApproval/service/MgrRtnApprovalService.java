package kr.happyjob.study.mgrApproval.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.mgrApproval.model.MgrImpApprovalModel;
import kr.happyjob.study.mgrApproval.model.MgrRtnApprovalModel;

public interface MgrRtnApprovalService {

	// 반품 목록 조회
	public List<MgrRtnApprovalModel> listRtnApproval (Map<String, Object> paramMap) throws Exception;
	
	// 반품 목록 카운트 조회
	public int countListRtnApproval (Map<String, Object> paramMap) throws Exception;
	
	// 반품 임원 승인여부 수정
	public int updateRtnMgrYn(Map<String, Object> paramMap) throws Exception;
}
