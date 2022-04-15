package kr.happyjob.study.scmDeal.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scmDeal.model.ReturnApplyModel;

public interface ReturnApplyService {

	
	public List<ReturnApplyModel> ReturnList(Map<String, Object> paramMap) throws Exception;
	
	public int CountReturnList(Map<String,Object> paramMap) throws Exception;
	
	public ReturnApplyModel ReturnSelect(Map<String,Object> paramMap) throws Exception;
	
	public int ReturnApproval(Map<String,Object> paramMap) throws Exception;
	
	public int ReturnStock(Map<String, Object> paramMap) throws Exception;
	
}
