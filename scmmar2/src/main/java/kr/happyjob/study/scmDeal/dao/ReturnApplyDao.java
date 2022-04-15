package kr.happyjob.study.scmDeal.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scmDeal.model.ReturnApplyModel;

public interface ReturnApplyDao {

	public List<ReturnApplyModel> ReturnList(Map<String, Object> paramMap);
	
	public int CountReturnList(Map<String , Object> paramMap);
	
	public ReturnApplyModel ReturnSelect(Map<String,Object> paramMap);
	
	public int ReturnApproval(Map<String,Object> paramMap);
	
	public int ReturnStock(Map<String, Object> paramMap);

	public int updateReturnDate(Map<String, Object> paramMap);

	public int insertDelReturn(Map<String, Object> paramMap);

	public void insertStock(Map<String, Object> paramMap);
	
}
