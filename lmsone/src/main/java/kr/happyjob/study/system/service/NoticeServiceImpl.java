package kr.happyjob.study.system.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.system.dao.NoticeDao;
import kr.happyjob.study.system.model.ComnGrpCodModel;
import kr.happyjob.study.system.model.NoticeDTO;
import kr.happyjob.study.system.model.NoticeModel;

@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private NoticeDao noticeDao;

	@Override
	public int selectListCnt(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		int listCount  = noticeDao.selectListCnt(map);
		return listCount;
	}

	@Override
	public List<NoticeDTO> selectList(Map<String, Object> map, RowBounds rb) throws Exception {
		// TODO Auto-generated method stub
		return noticeDao.selectList(map,rb);
	}

	@Override
	public void insertNotice(NoticeDTO notice) throws Exception {
		noticeDao.insertNotice(notice);
		
	}

	@Override
	public NoticeDTO selectDetail(int board_No) throws Exception {
		NoticeDTO notice = noticeDao.selectDetail(board_No);
		noticeDao.updateNoticeCtn(board_No);
		
		return notice;
	}

	@Override
	public void updateNotice(NoticeDTO notice) throws Exception {
		noticeDao.updateNotice(notice);
		
	}

	@Override
	public void deleteNotice(int board_No) throws Exception {
		noticeDao.deleteNotice(board_No);
		
	}

	@Override
	public List<NoticeDTO> mainNoticeList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return noticeDao.mainNoticeList(paramMap);
	}

	@Override
	public int mainNoticeCnt(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return noticeDao.mainNoticeCnt(paramMap);
	}

	/*@Override
	public List<NoticeModel> noticeList(Map<String, Object> paramMap) throws Exception{

		List<NoticeModel> noticeList = noticeDao.noticeList(paramMap);
		return noticeList;
	}

	@Override
	public int noticeCnt(Map<String, Object> paramMap) throws Exception {
		int noticeCnt = noticeDao.noticeCnt(paramMap);
		return noticeCnt;
	}

	@Override
	public NoticeModel noticeDetail(Map<String, Object> paramMap) throws Exception {

		NoticeModel noticeModel = noticeDao.noticeDetail(paramMap);
		return noticeModel;
	}

	@Override
	public int insertNotice(Map<String, Object> paramMap) throws Exception {

		int statusChange = noticeDao.insertNotice(paramMap);
		return statusChange;
	}

	@Override
	public int updateNotice(Map<String, Object> paramMap) throws Exception {

		int statusChange = noticeDao.updateNotice(paramMap);
		return statusChange;
	}

	@Override
	public int deleteNotice(Map<String, Object> paramMap) throws Exception {

		int statusChange = noticeDao.deleteNotice(paramMap);
		return statusChange;
	}*/

}
