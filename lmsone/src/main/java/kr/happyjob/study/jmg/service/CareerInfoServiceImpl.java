package kr.happyjob.study.jmg.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.jmg.dao.CareerInfoDao;

@Service
public class CareerInfoServiceImpl implements CareerInfoService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	CareerInfoDao careerInfoDao;
	
	/** 취업정보 목록 조회 */
	public List<Map<String, Object>> listCareerInfo(Map<String, Object> paramMap) throws Exception {
		
		List<Map<String, Object>> listCareerInfoMap = careerInfoDao.listCareerInfo(paramMap);
		
		return listCareerInfoMap;
	}
	
	/** 취업정보 목록 카운트 조회 */
	public int totalCount(Map<String, Object> paramMap) throws Exception {
		
		int totalCount = careerInfoDao.totalCount(paramMap);
		
		return totalCount;
	}
	
	/** 개인 취업정보 이력 조회 */
	public List<Map<String, Object>> careerDetail(Map<String, Object> paramMap) throws Exception {
		
		List<Map<String, Object>> listCareerDtlMap = careerInfoDao.careerDetail(paramMap);
		
		return listCareerDtlMap;
	}
}
