package kr.happyjob.study.scmTask.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scmTask.model.ImpOrderModel;

public interface ImpOrderService {

	public List<ImpOrderModel> ImpSerach(Map<String , Object> paramMap) throws Exception;
	
	public int countImp(Map<String,Object> paramMap) throws Exception;
	
}
