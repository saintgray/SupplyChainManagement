package kr.happyjob.study.notice.dao;

import java.util.List;
import java.util.Map;


import kr.happyjob.study.notice.model.NoticeModel;
import kr.happyjob.study.scm.model.FileModel;

public interface ScmNoticeDao {

	public int noticeTotalCnt(Map<String, Object> paramMap);
	public List<NoticeModel> selectNoticeList(Map<String, Object> paramMap);
	
	public NoticeModel detailNotice(Map<String, Object> paramMap);
	public List<FileModel> selectFilesByNoticeId(Map<String, Object> paramMap);
	
	public int insertNotice(NoticeModel data);
	public int insertNoticeFile(List<FileModel> files);
	
	public int updateHit(Map<String, Object> paramMap);
	
	
	public int updateNotice(Map<String, Object> paramMap);
	public int deleteNotice(Map<String, Object> paramMap);
	
	
	public List<FileModel> selectFilesByFileNo(List<String> filesNo);
	public FileModel selectOneFile(String file_no);
	public int deleteFile(Map<String, Object> paramMap);
	public int deleteFiles(List<FileModel> filesIdxList);
}
