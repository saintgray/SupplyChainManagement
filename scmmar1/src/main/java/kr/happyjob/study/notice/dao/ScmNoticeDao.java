package kr.happyjob.study.notice.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.common.comnUtils.FileModel;
import kr.happyjob.study.notice.model.NoticeModel;

public interface ScmNoticeDao {

	public int noticeTotalCnt(Map<String, Object> paramMap);
	public List<NoticeModel> selectNoticeList(Map<String, Object> paramMap);
	
	public NoticeModel detailNotice(Map<String, Object> paramMap);
	// for vue request
	public NoticeModel getNotice(String idx);
	public List<FileModel> selectFilesByNoticeId(Map<String, Object> paramMap);
	
	public int insertNotice(NoticeModel data);
	public int insertNoticeFile(List<FileModel> files);
	
	public int updateHit(Map<String, Object> paramMap);
	
	
	public int updateNotice(Map<String, Object> paramMap);
	public int deleteNotice(String idx);
	
	
	public List<FileModel> selectFilesByFileNo(List<String> filesNo);
	public FileModel selectOneFile(String file_no);
	public int deleteFile(Map<String, Object> paramMap);
	public int deleteFiles(List<FileModel> filesIdxList);
}
