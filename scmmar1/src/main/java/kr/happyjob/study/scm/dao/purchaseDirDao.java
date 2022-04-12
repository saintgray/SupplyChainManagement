package kr.happyjob.study.scm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.purchaseDirModel;

public interface purchaseDirDao {

	// list 조회
	public List<purchaseDirModel> listpurchaseDir(Map<String, Object> paramMap) throws Exception;
	// 재고량 조회
	public int total(Map<String, Object> paramMap) throws Exception;
}
