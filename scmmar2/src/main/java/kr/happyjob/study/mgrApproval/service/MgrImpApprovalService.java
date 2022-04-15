package kr.happyjob.study.mgrApproval.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.mgrApproval.model.MgrImpApprovalModel;

public interface MgrImpApprovalService {

	// 발주 목록 조회
	public List<MgrImpApprovalModel> listImpApproval (Map<String, Object> paramMap) throws Exception;
	
	// 발주 목록 카운트 조회
	public int countListImpApproval (Map<String, Object> paramMap) throws Exception;
	
	// 임원 승인여부 수정
	public int updateImpMgrYn(Map<String, Object> paramMap) throws Exception;
	
	// 발주 상세 목록 조회
	public List<MgrImpApprovalModel> listDtImpApproval(Map<String, Object> paramMap) throws Exception;
	
	// 발주 상세 목록 카운트 조회
	public int countListImpApprovalDt (Map<String, Object> paramMap) throws Exception; 

}
