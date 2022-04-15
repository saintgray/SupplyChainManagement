package kr.happyjob.study.scmTask.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scmTask.model.ImpOrderModel;

public interface ImpOrderDao {

	public List<ImpOrderModel> ImpSearch(Map<String, Object> paramMap);
	
	public int countImp(Map<String,Object> paramMap);
}
