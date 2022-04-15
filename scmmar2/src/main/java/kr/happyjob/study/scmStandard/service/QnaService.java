package kr.happyjob.study.scmStandard.service;

import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;

import kr.happyjob.study.scmStandard.model.QnaModel;

public interface QnaService {

	
	public int insertQna(Map<String, Object> paramMap) throws Exception;
	
	public List<QnaModel> qnaList(Map<String , Object> paramMap) throws Exception;
	
	public int countqnaList(Map<String,Object> paramMap) throws Exception;
	
	public QnaModel qnaSelect(Map<String,Object> paramMap) throws Exception;
	
}
