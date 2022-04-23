package kr.happyjob.study.scm.refund.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.refund.model.RefundInfoModel;

public interface RefundInfoService {

	// list 조회
	public List<RefundInfoModel> reinfolist(Map<String, Object> paramMap) throws Exception;
	// 총 값
	public int total(Map<String, Object> paramMap) throws Exception;
	// 단건 조회
	public RefundInfoModel onereinfo(Map<String, Object> paramMap) throws Exception;
	// 승인요청
	public int refupdate(Map<String,Object> paramMap) throws Exception;
	
}
