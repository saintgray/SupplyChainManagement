package kr.happyjob.study.ged.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.ged.model.SalesStatusModel;
import kr.happyjob.study.ged.model.SalesTopModel;

public interface SalesTopService {
	
	// 매출목록 리스트 조회
	public List<SalesTopModel> SalesTopList(Map<String, Object> paramMap)throws Exception;
	
	// 매출목록 카운트 조회
	public int SalesTopCnt(Map<String, Object> paramMap)throws Exception ;

}