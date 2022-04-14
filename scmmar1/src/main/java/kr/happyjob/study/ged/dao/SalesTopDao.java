package kr.happyjob.study.ged.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.ged.model.SalesTopModel;



public interface SalesTopDao {
	
	// 매출목록 리스트 조회
	public List<SalesTopModel> SalesTopList(Map<String, Object> paramMap)throws Exception;
	
	// 매출목록 카운트 조회
	public int SalesTopCnt(Map<String, Object> paramMap)throws Exception ;

}
