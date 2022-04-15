package kr.happyjob.study.crtCs.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.crtCs.model.CrtCsModel;

public interface CrtCsDao {

	int insertNewQuestion(Map<String, Object> paramMap);

	List<CrtCsModel> selectQnAlist(Map<String, Object> paramMap);

	int countQnAlist(Map<String, Object> paramMap);

	CrtCsModel selectQnaOne(Map<String, Object> paramMap);

	int updateQna(Map<String, Object> paramMap);

	int deleteQna(Map<String, Object> paramMap);
	
	
}
