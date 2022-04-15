package kr.happyjob.study.mgrSell.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.mgrSell.dao.MgrProfitAndLossDao;
import kr.happyjob.study.mgrSell.model.MgrProfitAndLossDtModel;
import kr.happyjob.study.mgrSell.model.MgrProfitAndLossModel;

@Service
public class MgrProfitAndLossServiceImpl implements MgrProfitAndLossService{

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	MgrProfitAndLossDao mgrProfitAndLossDao;

	// 손익 목록 조회
	public List<MgrProfitAndLossModel> listProfitAndLoss(Map<String, Object> paramMap) throws Exception {
		List<MgrProfitAndLossModel> listProfitAndLoss = mgrProfitAndLossDao.listProfitAndLoss(paramMap);
		return listProfitAndLoss;
	}

	// 손익 목록 카운트 조회
	public int countListProfitAndLoss(Map<String, Object> paramMap) throws Exception {
		int totalCount = mgrProfitAndLossDao.countListProfitAndLoss(paramMap);
		return totalCount;
	}

	// 손익 상세 목록 조회
	public List<MgrProfitAndLossDtModel> listDtProfitAndLoss(Map<String, Object> paramMap) throws Exception {
		List<MgrProfitAndLossDtModel> listDtProfitAndLoss = mgrProfitAndLossDao.listDtProfitAndLoss(paramMap);
		return listDtProfitAndLoss;
	}
	
	// 손익 상세 목록 카운트 조회
	public int countListDtProfitAndLoss(Map<String, Object> paramMap) throws Exception {
		int DtTotalCount = mgrProfitAndLossDao.countListDtProfitAndLoss(paramMap);
		return DtTotalCount;
	}

}
