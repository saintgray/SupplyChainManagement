package kr.happyjob.study.sta.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.sta.dao.StaDao;
import kr.happyjob.study.sta.model.StaModel;

@Service
public class StaServiceImpl implements StaService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	StaDao staDao;

	@Override
	public List<StaModel> liststa(Map<String, Object> paramMap) throws Exception {

		List<StaModel> liststa = staDao.liststa(paramMap);
		return liststa;
	}

	@Override
	public int countList(Map<String, Object> paramMap) throws Exception {
		
		int countList = staDao.countList(paramMap);
		return countList;
	}

	@Override
	public StaModel selectsatisfaction(int class_no) throws Exception {
		
		StaModel selectsatisfaction = staDao.selectsatisfaction(class_no);
		
		return selectsatisfaction;
	}

	@Override
	public int selectTotalCnt(Map<String, Object> resultMap) throws Exception {
		
		
		return staDao.selectTotalCnt(resultMap);
	}

	@Override
	public List<StaModel> selectSerchList(Map<String, Object> resultMap) throws Exception {
		// TODO Auto-generated method stub
		return staDao.selectSerchList(resultMap);
	}


	
	




}
