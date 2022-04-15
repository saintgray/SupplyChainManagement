package kr.happyjob.study.scmStandard.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scmStandard.model.QnaModel;

public interface QnaDao {

	public int insertQna(Map<String, Object> paramMap);
	
	public List<QnaModel> qnaList(Map<String , Object> paramMap);
	
	public int countqnaList(Map<String,Object> paramMap);

	public QnaModel qnaSelect(Map<String, Object> paramMap);
}
