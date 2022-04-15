package kr.happyjob.study.mgrApproval.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.mgrApproval.dao.MgrRtnApprovalDao;
import kr.happyjob.study.mgrApproval.model.MgrImpApprovalModel;
import kr.happyjob.study.mgrApproval.model.MgrRtnApprovalModel;

@Service
public class MgrRtnApprovalServiceImpl implements MgrRtnApprovalService{

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	MgrRtnApprovalDao mgrRtnAprrovalDao;

	// 반품 목록 조회
	public List<MgrRtnApprovalModel> listRtnApproval(Map<String, Object> paramMap) throws Exception {
		List<MgrRtnApprovalModel> listRtnApproval = mgrRtnAprrovalDao.listRtnApproval(paramMap);
		return listRtnApproval;
	}

	// 반품 목록 카운트 조회
	public int countListRtnApproval(Map<String, Object> paramMap) throws Exception {
		int totalCount = mgrRtnAprrovalDao.countListRtnApproval(paramMap);
		return totalCount;
	}
	
	// 반품 임원 승인여부 수정
	public int updateRtnMgrYn(Map<String, Object> paramMap) throws Exception {
		int ret = mgrRtnAprrovalDao.updateRtnMgrYn(paramMap);
		return ret;
	};
	
	
}
