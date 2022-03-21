package kr.happyjob.study.mng.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import kr.happyjob.study.mng.model.QnaReplyDto;

public interface QnaReplyDao {

	int selectQnaRListCnt(int board_No)  throws Exception ;

	List<QnaReplyDto> selectQnaRList(int board_No,RowBounds rb)  throws Exception ;

	void insertReply(QnaReplyDto reply)  throws Exception;

	void updateReply(QnaReplyDto reply) throws Exception;

	void deleteReply(int reply_No) throws Exception;


}
