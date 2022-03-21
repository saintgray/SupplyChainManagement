package kr.happyjob.study.mng.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.mng.dao.QnaReplyDao;
import kr.happyjob.study.mng.model.QnaReplyDto;

@Service
public class QnaReplyServiceImpl implements QnaReplyService {

	@Autowired
	private QnaReplyDao qnaReplyDao;
	
	@Override
	public int selectListCnt(int board_No) throws Exception {
		// TODO Auto-generated method stub
		return qnaReplyDao.selectQnaRListCnt(board_No);
	}

	@Override
	public List<QnaReplyDto> selectList(int board_No,RowBounds rb) throws Exception {
		// TODO Auto-generated method stub
		return qnaReplyDao.selectQnaRList(board_No,rb);
	}

	@Override
	public void insertReply(QnaReplyDto reply) throws Exception {
		qnaReplyDao.insertReply(reply);
		
	}

	@Override
	public void updateReply(QnaReplyDto reply) throws Exception {
		qnaReplyDao.updateReply(reply);
		
	}

	@Override
	public void deleteReply(int reply_No) throws Exception {
		qnaReplyDao.deleteReply(reply_No);
		
	}

}
