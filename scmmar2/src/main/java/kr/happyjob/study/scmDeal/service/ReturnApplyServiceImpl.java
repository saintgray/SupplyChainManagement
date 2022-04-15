package kr.happyjob.study.scmDeal.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scmDeal.dao.ReturnApplyDao;
import kr.happyjob.study.scmDeal.model.ReturnApplyModel;

@Service
public class ReturnApplyServiceImpl implements ReturnApplyService{

	@Autowired
	ReturnApplyDao returnApplyDao;
	
	@Override
	public List<ReturnApplyModel> ReturnList(Map<String, Object> paramMap) throws Exception {

		List<ReturnApplyModel> ReturnList = returnApplyDao.ReturnList(paramMap);
		
		return ReturnList;
	}

	@Override
	public int CountReturnList(Map<String, Object> paramMap) throws Exception {
		
		int totalCount = returnApplyDao.CountReturnList(paramMap);
		
		return totalCount;
	}

	@Override
	public ReturnApplyModel ReturnSelect(Map<String, Object> paramMap) throws Exception {

		ReturnApplyModel returnSelectModel = returnApplyDao.ReturnSelect(paramMap);
		
		return returnSelectModel;
	}

	@Override
	public int ReturnApproval(Map<String, Object> paramMap) throws Exception {
		
		int ret = returnApplyDao.ReturnApproval(paramMap);
		if(ret>0){
			int result =  returnApplyDao.updateReturnDate(paramMap);
			if(result>0){
				int result2 = returnApplyDao.insertDelReturn(paramMap);
				
				if(result2>0){
					returnApplyDao.insertStock(paramMap);
				}
				
			}
			
		}
		
		
		return ret;
	}

	@Override
	public int ReturnStock(Map<String, Object> paramMap) throws Exception {
		
		int ret = returnApplyDao.ReturnStock(paramMap);
		
		return ret;
	}
	

}
