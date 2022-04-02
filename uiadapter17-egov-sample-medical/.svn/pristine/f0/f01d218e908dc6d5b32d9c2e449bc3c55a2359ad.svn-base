package com.nexacro.sample.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.nexacro.sample.service.NoticeService;
import com.nexacro.sample.service.impl.ibatis.NoticeDAO;


/**
 * 
 * <pre>
 * 
 * @desc 공통코드.
 * @package com.nexacro.sample.service
 * 
 *          <pre>
 * 
 * @author 이미혜
 * @since 2019. 10.6
 * @version 1.0
 * @see =================== 변경 내역 ================== 날짜 변경자 내용
 *      ------------------------------------------------
 * 
 */

@Service("noticeService")
public class NoticeServiceImpl implements NoticeService {

	@Resource(name="noticeDAO")
	private NoticeDAO noticeDAO;
	
	@Override
	public List<Map<String, String>> list(Map<String, String> searchMap) {
		
		List<Map<String, String>> list = noticeDAO.list(searchMap);
		
		return list;
	
	}
	
	@Override
	public Map<String, String> view(Map<String, String> searchMap) {
		
		Map<String, String> list = noticeDAO.view(searchMap);
		
		return list;
		
	}




	@Override
	public void insertnotice(Map<String, Object> dataMap) {
		// TODO Auto-generated method stub
		
		  noticeDAO.insertnotice(dataMap);
		  
		  return;
		
		
	}

	@Override
	public void updatenotice(Map<String, Object> dataMap) {
		// TODO Auto-generated method stub
		  noticeDAO.updatenotice(dataMap);
		  
		  return;
		
	};

	
	@Override
	public List<Map<String, String>> MSGlist(Map<String, String> msg) {
		return noticeDAO.msgSelect(msg);
	}
	
	@Override
	public Map<String,String> notedetailinfo(String wno) {
		return noticeDAO.notedetailinfo(wno);
	}

	@Override
	public void sendNote(Map<String, String> map) {
		// TODO Auto-generated method stub
		noticeDAO.sendNote(map);
		return; 
	}
	
	//공지사항 list
	@Override
	public List<Map<String, String>> NoticeList() {
		return noticeDAO.NoticeList();
	}

	//공지글 상세보기
	@Override
	public Map<String, String> NoticeDetail(String wcno) {
		return noticeDAO.NoticeDetail(wcno);
	}

	@Override
	public void deletenotice(String wcno) {
		
		
		 noticeDAO.deletenotice(wcno);
		
	}	

	

}
