package kr.happyjob.study.system.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.system.model.comcombo;

public interface ComnComboDao {
	/** 거래처 목록 조회 */
	public List<comcombo> selectclientlist(Map<String, Object> paramMap) throws Exception;
	
	/** 제품  목록 조회 */
	public List<comcombo> selectGoodComCombo(Map<String, Object> paramMap) throws Exception;
	
	/** 창고 목록 조회 */
	public List<comcombo> selectwhlist(Map<String, Object> paramMap) throws Exception;
		
		
}
