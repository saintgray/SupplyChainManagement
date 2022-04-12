package kr.happyjob.study.ged.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.ged.model.OrderConfirmModel;
import kr.happyjob.study.ged.model.SalesStatusModel;

public interface SalesStatusDao {
	
	// 매출목록 리스트 조회
	public List<SalesStatusModel> SalesStatusList(Map<String, Object> paramMap)throws Exception;
	
	// 매출목록 카운트 조회
	public int SalesStatusCnt(Map<String, Object> paramMap)throws Exception ;

	public List<SalesStatusModel> SalesStatusOne(Map<String, Object> paramMap)throws Exception ;

	public int SalesStatusOneCnt(Map<String, Object> paramMap)throws Exception ;

}
