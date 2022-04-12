package kr.happyjob.study.qna.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.happyjob.study.qna.model.QnaListRow;
import kr.happyjob.study.qna.model.SearchParam;

public interface QnaDao {

	int getTotalCount(SearchParam param);
	List<QnaListRow> getQnaList(SearchParam param);

}
