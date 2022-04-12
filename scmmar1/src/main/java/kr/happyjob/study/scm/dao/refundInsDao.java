package kr.happyjob.study.scm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.purchaseDirModel;
import kr.happyjob.study.scm.model.refundInsModel;

public interface refundInsDao {

	// list 조회
	public List<refundInsModel> relist(Map<String, Object> paramMap) throws Exception;
	// 총 값
	public int total(Map<String, Object> paramMap) throws Exception;
		
}
