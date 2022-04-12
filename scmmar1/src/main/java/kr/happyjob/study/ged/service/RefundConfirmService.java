package kr.happyjob.study.ged.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.ged.model.RefundConfirmModel;

public interface RefundConfirmService {
	
	    // 반품목록 리스트 조회
		public List<RefundConfirmModel> refundConfirmList(Map<String, Object> paramMap)throws Exception;
		
		// 발주목록 카운트 조회
		public int refundConfirmCnt(Map<String, Object> paramMap)throws Exception ;
		
		//발주 승인
		public void updaterefundConfirm(Map<String, Object> paramMap)throws Exception;

}



