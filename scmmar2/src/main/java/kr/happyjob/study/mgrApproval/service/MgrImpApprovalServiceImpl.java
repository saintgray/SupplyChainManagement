package kr.happyjob.study.mgrApproval.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.mgrApproval.dao.MgrImpApprovalDao;
import kr.happyjob.study.mgrApproval.model.MgrImpApprovalModel;

@Service
public class MgrImpApprovalServiceImpl implements MgrImpApprovalService{

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	MgrImpApprovalDao mgrImpAprrovalDao;

	// 발주 목록 조회
	public List<MgrImpApprovalModel> listImpApproval(Map<String, Object> paramMap) throws Exception {
		List<MgrImpApprovalModel> listImpApproval = mgrImpAprrovalDao.listImpApproval(paramMap);
		return listImpApproval;
	}

	// 발주 목록 카운트 조회
	public int countListImpApproval(Map<String, Object> paramMap) throws Exception {
		int totalCount = mgrImpAprrovalDao.countListImpApproval(paramMap);
		return totalCount;
	}

	// 발주 임원 승인여부 수정
	public int updateImpMgrYn(Map<String, Object> paramMap)  throws Exception {
		int ret = mgrImpAprrovalDao.updateImpMgrYn(paramMap);
		if(ret > 0){
			mgrImpAprrovalDao.insertStockCnt(paramMap);
		}
		return ret;
	}

	// 발주 상세 목록 조회
	public List<MgrImpApprovalModel> listDtImpApproval(Map<String, Object> paramMap) throws Exception {
		List<MgrImpApprovalModel> listDtImpApproval = mgrImpAprrovalDao.listDtImpApproval(paramMap);
		return listDtImpApproval;
	}
	
	// 발주 상세 목록 카운트 조회
	public int countListImpApprovalDt(Map<String, Object> paramMap) throws Exception {
		int DtTotalCount = mgrImpAprrovalDao.countListImpApprovalDt(paramMap);
		
		return DtTotalCount;
	}
	
	
}
