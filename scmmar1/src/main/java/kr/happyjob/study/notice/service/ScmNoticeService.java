package kr.happyjob.study.notice.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.happyjob.study.notice.model.NoticeModel;
import kr.happyjob.study.scm.model.FileModel;

@Service
public interface ScmNoticeService {

	List<NoticeModel> noticeList(Map<String, Object> paramMap) throws Exception;

	int noticeTotalCnt(Map<String, Object> paramMap) throws Exception;

	NoticeModel detailNotice(Map<String, Object> paramMap) throws Exception;

	public int insertNotice(NoticeModel data, List<MultipartFile> files,HttpServletRequest request) throws Exception;

    public int updateNotice(NoticeModel latestNoticeInfo, Map<String,Object> params, List<MultipartFile> files, List<String> delTargets, HttpServletRequest req) throws Exception;

	int deleteNotice(String idx) throws Exception;


	List<FileModel> selectFilesByNoticeId(Map<String, Object> paramMap) throws Exception;
	List<FileModel> selectFilesByFileNo(List<String> delTargets);
	FileModel selectOneFile(String file_no);

	

}
