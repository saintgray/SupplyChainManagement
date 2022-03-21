package kr.happyjob.study.mng.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.mng.dao.QnaDao;
import kr.happyjob.study.mng.model.QnaDto;

@Service
public class QnaServiceImpl implements QnaService {
	
	@Autowired
	private QnaDao qnaDao;

	@Override
	public int selectListCnt(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return qnaDao.selectListCnt(map);
	}

	@Override
	public List<QnaDto> selectList(Map<String, Object> map, RowBounds rb) throws Exception {
		// TODO Auto-generated method stub
		return qnaDao.selectList(map,rb);
	}

	@Override
	public QnaDto selectQnaDetail(int board_No) throws Exception {
		// TODO Auto-generated method stub
		return qnaDao.selectQnaDetail(board_No);
	}

	@Override
	public void insertQna(QnaDto qna) throws Exception {
		qnaDao.insertQna(qna);
		
	}

	@Override
	public void deleteQna(int board_No) throws Exception {
		qnaDao.deleteQna(board_No);
	}

	@Override
	public void updateQna(QnaDto qna) throws Exception {
		qnaDao.updateQna(qna);
		
	}

}
