package kr.happyjob.study.ged.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.ged.model.orderConfirmModel;

public interface orderConfirmDao {
	
	// 발주목록 리스트 조회
	public List<orderConfirmModel> orderConfirmList(Map<String, Object> paramMap)throws Exception;
	
	// 발주목록 카운트 조회
	public int orderConfirmCnt(Map<String, Object> paramMap)throws Exception ;
	
	//발주 승인
    public void updateorderConfirm(Map<String, Object> paramMap)throws Exception;

}
