package kr.happyjob.study.mgrSell.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.mgrSell.model.MgrProfitAndLossDtModel;
import kr.happyjob.study.mgrSell.model.MgrProfitAndLossModel;

public interface MgrProfitAndLossDao {

	/** 손익 목록 조회 */
	//listSellProfit 가 쿼리문 ID가 됌.
	public List<MgrProfitAndLossModel> listProfitAndLoss(Map<String, Object> paramMap);
	
	/** 손익 목록 카운트 조회 */
	public int countListProfitAndLoss(Map<String, Object> paramMap);
	
	/** 손익 상세 목록 조회	 */
	public List<MgrProfitAndLossDtModel> listDtProfitAndLoss(Map<String, Object> paramMap);
	
	/** 손익 상세 목록 카운트 조회	 */
	public int countListDtProfitAndLoss(Map<String, Object> paramMap);
}
