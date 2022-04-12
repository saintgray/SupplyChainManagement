package kr.happyjob.study.scm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.refundInfoModel;

public interface refundInfoDao {

	// list 조회
	public List<refundInfoModel> reinfolist(Map<String, Object> paramMap) throws Exception;
	// 총 값
	public int total(Map<String, Object> paramMap) throws Exception;
	// 단건 조회
	public refundInfoModel onereinfo(Map<String, Object> paramMap) throws Exception;
	// 승인요청
	public int refupdate(Map<String,Object> paramMap) throws Exception;	
}
