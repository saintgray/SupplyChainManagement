package kr.happyjob.study.qna.service;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import kr.happyjob.study.qna.exception.NotHaveAuthToWatchQnaException;
import kr.happyjob.study.qna.model.PageInfo;
import kr.happyjob.study.qna.model.QnaDetail;

@Service
public interface QnaService {

	PageInfo getQnaList(PageInfo info, HttpSession session);

	QnaDetail getQnaDetail(String id, HttpSession session) throws NotHaveAuthToWatchQnaException;

	int updateQna(QnaDetail data,String loginID) throws Exception;

	int insertQna(QnaDetail data,String loginID) throws Exception;

	int deleteQna(QnaDetail data, String loginID) throws Exception;

}
