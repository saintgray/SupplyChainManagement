package kr.happyjob.study.crtCs.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.crtCs.model.CrtCsModel;

public interface CrtCsService {

	int insertNewQuestion(Map<String, Object> paramMap);

	List<CrtCsModel> selectQnAlist(Map<String, Object> paramMap);

	int countQnAlist(Map<String, Object> paramMap);

	CrtCsModel selectQnaOne(Map<String, Object> paramMap);

	int updateQna(Map<String, Object> paramMap);

	int deleteQna(Map<String, Object> paramMap);

}
