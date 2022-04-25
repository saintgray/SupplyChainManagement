package kr.happyjob.study.scm.refund.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.entity.PurchaseInfo;
import kr.happyjob.study.entity.RefundInfo;

public interface RefundInfoService {

	// list 조회
	public List<PurchaseInfo> getRefundInfoList(Map<String, Object> paramMap) throws Exception;
	// 총 값
	public int total(Map<String, Object> paramMap) throws Exception;
	// 단건 조회
	public RefundInfo oneRefundInfo(Map<String, Object> paramMap) throws Exception;
	// 승인요청
	public int refupdate(Map<String,Object> paramMap) throws Exception;
	
	
}
