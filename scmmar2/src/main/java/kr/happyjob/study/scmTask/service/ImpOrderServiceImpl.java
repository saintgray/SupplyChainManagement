package kr.happyjob.study.scmTask.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scmTask.dao.ImpOrderDao;
import kr.happyjob.study.scmTask.model.ImpOrderModel;

@Service
public class ImpOrderServiceImpl implements ImpOrderService{

	@Autowired
	ImpOrderDao impOrderDao;
	
	@Override
	public List<ImpOrderModel> ImpSerach(Map<String, Object> paramMap) throws Exception {
		
		List<ImpOrderModel> ImpSerach = impOrderDao.ImpSearch(paramMap);
		
		return ImpSerach;
	}

	@Override
	public int countImp(Map<String, Object> paramMap) throws Exception {
		
		int totalCount = impOrderDao.countImp(paramMap);
		
		return totalCount;
	}

}
