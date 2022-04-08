package kr.happyjob.study.notice.dao;

import java.util.List;
import java.util.Map;


import kr.happyjob.study.notice.model.NoticeModel;
import kr.happyjob.study.scm.model.FileModel;

public interface ScmNoticeDao {

	public int noticeTotalCnt(Map<String, Object> paramMap) throws Exception;

	public List<NoticeModel> selectNoticeList(Map<String, Object> paramMap) throws Exception;

	public NoticeModel detailNotice(Map<String, Object> paramMap) throws Exception;

	public int numPlus() throws Exception;

	public int insertNotice(NoticeModel data) throws Exception;

	public int insertNoticeFile(List<FileModel> files) throws Exception;

	public int updateHit(Map<String, Object> paramMap) throws Exception;

	public int updateNotice(Map<String, Object> paramMap) throws Exception;

	public int deleteNotice(Map<String, Object> paramMap) throws Exception;
	
	//파일 조회
	public List<FileModel> selectFile(Map<String, Object> paramMap);
	
	//파일 삭제
	public int deleteFile(Map<String, Object> paramMap);
}
