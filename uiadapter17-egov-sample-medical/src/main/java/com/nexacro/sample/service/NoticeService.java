package com.nexacro.sample.service;

import java.util.List;
import java.util.Map;



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
 * @since 2019. 10.6.
 * @version 1.0
 * @see =================== 변경 내역 ================== 날짜 변경자 내용
 *      ------------------------------------------------
 * 
 */

public interface NoticeService {

	List<Map<String, String>> list(Map<String, String> searchMap);


	Map<String, String> view(Map<String, String> searchMap);


	void insertnotice(Map<String, Object> dataMap);


	void updatenotice(Map<String, Object> dataMap);
	
	
    List<Map<String, String>> MSGlist(Map<String, String> msg);
	
	Map<String,String> notedetailinfo(String wno);
	
	void sendNote(Map<String, String> map);
	
	//전체 공지사항 불러오기
	List<Map<String, String>> NoticeList();

	//공지글 상세보기
	Map<String, String> NoticeDetail(String wcno);


	void deletenotice(String wcno);

}
