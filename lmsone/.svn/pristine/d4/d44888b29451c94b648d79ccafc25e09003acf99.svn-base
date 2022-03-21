package kr.happyjob.study.system.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import kr.happyjob.study.system.model.NoticeDTO;
import kr.happyjob.study.system.model.NoticeModel;

public interface NoticeService {

	public int selectListCnt(Map<String, Object> map) throws Exception;

	public List<NoticeDTO> selectList(Map<String, Object> map, RowBounds rb) throws Exception;

	public void insertNotice(NoticeDTO notice) throws Exception;

	public NoticeDTO selectDetail(int board_No) throws Exception;

	public void updateNotice(NoticeDTO notice) throws Exception;

	public void deleteNotice(int board_No) throws Exception;

	public List<NoticeDTO> mainNoticeList(Map<String, Object> paramMap) throws Exception;

	public int mainNoticeCnt(Map<String, Object> paramMap) throws Exception;


	/*// 공지사항 리스트 조회
	public List<NoticeModel> noticeList(Map<String, Object> paramMap)throws Exception ;
	
	// 공지사항 목록 카운트 조회
	public int noticeCnt(Map<String, Object> paramMap)throws Exception ;
	
	// 공지사항 단건 조회
	public NoticeModel noticeDetail(Map<String, Object> paramMap)throws Exception ;
	
	// 공지사항 저장
	public int insertNotice(Map<String, Object> paramMap) throws Exception;
	
	// 공지사항 수정
	public int updateNotice(Map<String, Object> paramMap) throws Exception;
	
	// 공지사항 삭제
	public int deleteNotice(Map<String, Object> paramMap) throws Exception;*/
	
}
