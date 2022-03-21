package kr.happyjob.study.mng.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import kr.happyjob.study.mng.model.QnaDto;

public interface QnaDao {

	int selectListCnt(Map<String, Object> map)  throws Exception ;

	List<QnaDto> selectList(Map<String, Object> map, RowBounds rb)  throws Exception ;

	QnaDto selectQnaDetail(int board_No) throws Exception;

	void insertQna(QnaDto qna) throws Exception;

	void deleteQna(int board_No) throws Exception;

	void updateQna(QnaDto qna)  throws Exception;

}
