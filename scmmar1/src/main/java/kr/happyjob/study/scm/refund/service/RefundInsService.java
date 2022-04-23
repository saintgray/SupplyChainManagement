package kr.happyjob.study.scm.refund.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.refund.model.RefundInsModel;

public interface RefundInsService {

	// list 조회
	public List<RefundInsModel> relist(Map<String, Object> paramMap) throws Exception;
	// 총 값
	public int total(Map<String, Object> paramMap) throws Exception;
	
}
