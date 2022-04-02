package com.nexacro.sample.service.impl.ibatis;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.nexacro.spring.dao.ibatis.NexacroIbatisAbstractDAO;

@Repository("noticeDAO")
public class NoticeDAO  extends NexacroIbatisAbstractDAO{

	
	@SuppressWarnings("unchecked")
	public List<Map<String, String>> list(Map<String, String> searchMap) {
		
		return (List<Map<String, String>>) list("notice.list",searchMap);
	}
	
	
	
	
	@SuppressWarnings("unchecked")
	public Map<String, String> view(Map<String, String> searchMap) {
		
		return (Map<String, String>) select("notice.selectone",searchMap);
	}
	
	
	@SuppressWarnings("unchecked")
	public void insertnotice(Map<String, Object> dataMap) {
		insert("notice.insertnotice",dataMap);
		return;
	}
	
	
	@SuppressWarnings("unchecked")
	public void updatenotice(Map<String, Object> dataMap) {
		update("notice.updatenotice",dataMap);
		return ;
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, String>> msgSelect(Map<String, String> msg) {
		return (List<Map<String, String>>) list("notice.msgSelect", msg);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String,String> notedetailinfo(String wno) {
		Map parm = new HashMap();
		parm.put("wno", wno);
		
		
		return (Map<String,String>) select("notice.notedetailinfo", parm);
	}
	
	@SuppressWarnings("unchecked")
	public void sendNote(Map<String, String> map) {
		insert("notice.sendNote", map);
		return;
	}	
	
	//공지사항 list
	public List<Map<String, String>> NoticeList() {
		return (List<Map<String, String>>) list("notice.NoticeList");
	}

	//공지글 상세보기
	public Map<String, String> NoticeDetail(String wcno) {
		return (Map<String, String>) select("notice.NoticeDetail",wcno);
	}	
	//공지글 삭제하기 테스트1
	@SuppressWarnings("unchecked")
	public void deletenotice(String wcno) {
		delete("notice.deletelist",wcno);
		return ;
	}
	
}
