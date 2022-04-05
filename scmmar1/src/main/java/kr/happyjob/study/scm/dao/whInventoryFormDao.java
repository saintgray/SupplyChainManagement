package kr.happyjob.study.scm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.whInventoryFormModel;
import kr.happyjob.study.scm.model.whcntModel;

public interface whInventoryFormDao {

	// list 조회
	public List<whInventoryFormModel> whlist(Map<String, Object> paramMap) throws Exception;
	// 재고량 조회
	public whcntModel cnt(Map<String, Object> paramMap) throws Exception;
}
