package kr.happyjob.study.scmStandard.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.scmStandard.model.NoticeBoardModel;
import kr.happyjob.study.scmStandard.model.NoticeFileModel;

public interface NoticeBoardDao {

	// 공지사항 목록 조회
	public List<NoticeBoardModel> noticeBoardlist(Map<String, Object> paramMap) throws Exception;
	
	// 공지사항 카운트
	public int countListNoticeCod(Map<String, Object> paramMap) throws Exception;
	
	// 공지사항 조회수
	public int updateNoticeCnt(Map<String, Object> paramMap) throws Exception;
	
	// 공지사항 단건 조회
	public NoticeBoardModel selectNoticeCod(Map<String, Object> paramMap) throws Exception;
	
	// 공지사항 파일 가져오기
	public NoticeBoardModel selectFile(Map<String, Object> paramMap) throws Exception;

	// 공지사항 신규 등록
	public int insertNoticecode(Map<String, Object> paramMap) throws Exception;

	// 공지사항 수정
	public int updateNoticecode(Map<String, Object> paramMap) throws Exception;
	
	//파일 삭제
	//public int deleteFile(Map<String, Object> paramMap);

	// 공지사항 삭제
	public void deleteNoticeCod(Map<String, Object> paramMap) throws Exception;

}
