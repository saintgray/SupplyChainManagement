package kr.happyjob.study.qna.service;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import kr.happyjob.study.qna.model.PageInfo;
import kr.happyjob.study.qna.model.QnaDetail;

@Service
public interface QnaService {

	PageInfo getQnaList(PageInfo info, HttpSession session);

	QnaDetail getQnaDetail(String id, HttpSession session);

}
