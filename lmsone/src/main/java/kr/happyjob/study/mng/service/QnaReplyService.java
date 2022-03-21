package kr.happyjob.study.mng.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import kr.happyjob.study.mng.model.QnaReplyDto;

public interface QnaReplyService {

	int selectListCnt(int board_No) throws Exception;

	List<QnaReplyDto> selectList(int board_No, RowBounds rb) throws Exception;

	void insertReply(QnaReplyDto reply) throws Exception;

	void updateReply(QnaReplyDto reply) throws Exception;

	void deleteReply(int reply_No) throws Exception;

}
