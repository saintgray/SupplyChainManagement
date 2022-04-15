package kr.happyjob.study.qna.dao;

import java.util.List;

import kr.happyjob.study.qna.model.QnaDetail;
import kr.happyjob.study.qna.model.QnaListRow;
import kr.happyjob.study.qna.model.SearchParam;

public interface QnaDao {

	int getTotalCount(SearchParam param);
	List<QnaListRow> getQnaList(SearchParam param);
	QnaDetail getQnaInfo(String id);
	int deleteQna(String qna_id);
	int updateQna(QnaDetail data);
	int insertQna(QnaDetail data);

}
