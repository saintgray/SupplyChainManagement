package kr.happyjob.study.ged.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.ged.dao.SalesStatusDao;
import kr.happyjob.study.ged.model.SalesStatusModel;

@Service
public class SalesStatusServiceImpl implements SalesStatusService{
	
	@Autowired
	SalesStatusDao salesStatusDao;

	@Override
	public List<SalesStatusModel> SalesStatusList(Map<String, Object> paramMap) throws Exception {
		
		List<SalesStatusModel> SalesStatusList = salesStatusDao.SalesStatusList(paramMap);
		return SalesStatusList;
	}

	@Override
	public int SalesStatusCnt(Map<String, Object> paramMap) throws Exception {
		int SalesStatusCnt = salesStatusDao.SalesStatusCnt(paramMap);
		return SalesStatusCnt;
	}

	@Override
	public List<SalesStatusModel> SalesStatusOne(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return salesStatusDao.SalesStatusOne(paramMap);
	}

	@Override
	public int SalesStatusOneCnt(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return salesStatusDao.SalesStatusOneCnt(paramMap);
	}

}
