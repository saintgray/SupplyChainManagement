package kr.happyjob.study.crtCs.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.crtCs.dao.CrtCsDao;
import kr.happyjob.study.crtCs.model.CrtCsModel;

@Service
public class CrtCsServiceImpl implements CrtCsService {

	@Autowired
	CrtCsDao crtCsDao;

	@Override
	public int insertNewQuestion(Map<String, Object> paramMap) {
		return crtCsDao.insertNewQuestion(paramMap);
	}

	@Override
	public List<CrtCsModel> selectQnAlist(Map<String, Object> paramMap) {
		return crtCsDao.selectQnAlist(paramMap);
	}

	@Override
	public int countQnAlist(Map<String, Object> paramMap) {
		return crtCsDao.countQnAlist(paramMap);
	}

	@Override
	public CrtCsModel selectQnaOne(Map<String, Object> paramMap) {
		return crtCsDao.selectQnaOne(paramMap);
	}

	@Override
	public int updateQna(Map<String, Object> paramMap) {
		return crtCsDao.updateQna(paramMap);
	}

	@Override
	public int deleteQna(Map<String, Object> paramMap) {
		return crtCsDao.deleteQna(paramMap);
	}
	
	
	
	
}
