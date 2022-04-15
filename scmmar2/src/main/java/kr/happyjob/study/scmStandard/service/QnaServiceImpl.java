package kr.happyjob.study.scmStandard.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scmStandard.dao.QnaDao;
import kr.happyjob.study.scmStandard.model.QnaModel;

@Service
public class QnaServiceImpl implements QnaService{

	
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	private final String className = this.getClass().toString();
	
	@Autowired
	QnaDao qnaDao;
	
	@Override
	public int insertQna(Map<String, Object> paramMap) throws Exception {
		
		int ret = qnaDao.insertQna(paramMap);
		
		return ret;
	}

	@Override
	public List<QnaModel> qnaList(Map<String, Object> paramMap) throws Exception {
		
		List<QnaModel> qnaList = qnaDao.qnaList(paramMap);
		
		return qnaList;
	}

	@Override
	public int countqnaList(Map<String, Object> paramMap) throws Exception {
		
		int totalCount = qnaDao.countqnaList(paramMap);
		
		return totalCount;
	}

	@Override
	public QnaModel qnaSelect(Map<String, Object> paramMap) throws Exception {
		
		QnaModel qnaModel = qnaDao.qnaSelect(paramMap);
		
		return qnaModel;
	}

	
}
