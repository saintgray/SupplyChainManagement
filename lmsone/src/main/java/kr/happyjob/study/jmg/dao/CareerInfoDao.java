package kr.happyjob.study.jmg.dao;

import java.util.List;
import java.util.Map;

public interface CareerInfoDao {

	/** 취업정보 목록 조회 */
	public List<Map<String, Object>> listCareerInfo(Map<String, Object> paramMap);
	
	/** 취업정보 목록 카운트 조회 */
	public int totalCount(Map<String, Object> paramMap);

	/** 개인 취업정보 이력 조회 */
	public List<Map<String, Object>> careerDetail(Map<String, Object> paramMap);
}
