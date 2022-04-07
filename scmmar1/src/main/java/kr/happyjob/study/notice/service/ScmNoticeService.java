package kr.happyjob.study.notice.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import kr.happyjob.study.notice.model.FileModel;
import kr.happyjob.study.notice.model.NoticeModel;

@Service
public interface ScmNoticeService {

	List<NoticeModel> noticeList(Map<String, Object> paramMap) throws Exception;

	int noticeTotalCnt(Map<String, Object> paramMap) throws Exception;

	NoticeModel detailNotice(Map<String, Object> paramMap) throws Exception;

//	public int insertNotice(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;

//	public int updateNotice(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;

	int deleteNotice(Map<String, Object> paramMap) throws Exception;

	//파일 조회
	List<FileModel> selectFile(Map<String, Object> paramMap) throws Exception;

}
