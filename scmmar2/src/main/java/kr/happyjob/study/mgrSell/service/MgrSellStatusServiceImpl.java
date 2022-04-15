package kr.happyjob.study.mgrSell.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.mgrSell.dao.MgrSellStatusDao;
import kr.happyjob.study.mgrSell.model.MgrSellStatusDtModel;
import kr.happyjob.study.mgrSell.model.MgrSellStatusModel;

@Service
public class MgrSellStatusServiceImpl implements MgrSellStatusService{

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	MgrSellStatusDao mgrSellStatusDao;

	// 매출 목록 조회
	public List<MgrSellStatusModel> listSellStauts(Map<String, Object> paramMap) throws Exception {
		List<MgrSellStatusModel> listSellStauts = mgrSellStatusDao.listSellStauts(paramMap);
		return listSellStauts;
	}

	// 매출 목록 카운트 조회
	public int countListSellStauts(Map<String, Object> paramMap) throws Exception {
		int totalCount = mgrSellStatusDao.countListSellStauts(paramMap);
		return totalCount;
	}

	// 매출 상세 목록 조회
	public List<MgrSellStatusDtModel> listDtSellStauts(Map<String, Object> paramMap) throws Exception {
		List<MgrSellStatusDtModel> listDtSellStauts = mgrSellStatusDao.listDtSellStauts(paramMap);
		return listDtSellStauts;
	}
	
	// 매출 상세 목록 카운트 조회
	public int countListDtSellStauts(Map<String, Object> paramMap) throws Exception {
		int DtTotalCount = mgrSellStatusDao.countListDtSellStauts(paramMap);
		return DtTotalCount;
	}
	
}
