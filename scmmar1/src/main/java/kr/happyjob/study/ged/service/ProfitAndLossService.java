package kr.happyjob.study.ged.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.ged.model.ProfitAndLossModel;



public interface ProfitAndLossService {
	
	// 매출목록 리스트 조회
	public List<ProfitAndLossModel> ProfitAndLossList(Map<String, Object> paramMap)throws Exception;
	
	// 매출목록 카운트 조회
	public int ProfitAndLossCnt(Map<String, Object> paramMap)throws Exception ;

	public List<ProfitAndLossModel> ProfitAndLossOne(Map<String, Object> paramMap)throws Exception ;

	public int ProfitAndLossOneCnt(Map<String, Object> paramMap)throws Exception ;

}