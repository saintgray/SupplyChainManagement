package kr.happyjob.study.mgrSell.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.mgrSell.model.MgrSellStatusDtModel;
import kr.happyjob.study.mgrSell.model.MgrSellStatusModel;

public interface MgrSellStatusService {

	// 매출 목록 조회
	public List<MgrSellStatusModel> listSellStauts (Map<String, Object> paramMap) throws Exception;
	
	// 매출 목록 카운트 조회
	public int countListSellStauts (Map<String, Object> paramMap) throws Exception;
	
	// 매출 상세 목록 조회
	public List<MgrSellStatusDtModel> listDtSellStauts(Map<String, Object> paramMap) throws Exception;
	
	// 매출 상세 목록 카운트 조회
	public int countListDtSellStauts (Map<String, Object> paramMap) throws Exception; 
}
