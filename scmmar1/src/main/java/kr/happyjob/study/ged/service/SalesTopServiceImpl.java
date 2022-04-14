package kr.happyjob.study.ged.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.ged.dao.SalesTopDao;
import kr.happyjob.study.ged.model.SalesTopModel;



@Service
public class SalesTopServiceImpl implements SalesTopService{
	
	@Autowired
	SalesTopDao salesTopDao;

	public List<SalesTopModel> SalesTopList(Map<String, Object> paramMap) throws Exception {
		
		List<SalesTopModel> SalesTopList = salesTopDao.SalesTopList(paramMap);
		return SalesTopList;
	}

	@Override
	public int SalesTopCnt(Map<String, Object> paramMap) throws Exception {
		int SalesTopCnt = salesTopDao.SalesTopCnt(paramMap);
		return SalesTopCnt;
	}

}
