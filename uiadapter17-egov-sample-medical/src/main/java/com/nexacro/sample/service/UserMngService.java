package com.nexacro.sample.service;

import java.util.List;
import java.util.Map;

import com.nexacro.sample.vo.LoginVO;

/**
 * 
 * <pre>
 * @desc    Login 처리를 한다.
 * @package com.nexacro.Login.service
 * <pre>
 * 
 * @author  김태현
 * @since   2019. 9. 19.
 * @version 1.0
 * @see
 * =================== 변경 내역 ==================
 * 날짜			변경자		내용
 * ------------------------------------------------
 * 2019.09.19.	김태현	        내용수정
 * 2019.09.27	이미혜		사용자 리스트&상세정보 
 * 
 * 
 * 
 */
public interface UserMngService {

	int selectUserPersoncnt(Map<String,String> userinfo);
	

	void insertUserPersoninfo(Map<String,String> userinfo);
	
	void updateUserPersoninfo(Map<String,String> userinfo);
	
	void insertUserPersonSkill(Map<String,String> skillInfo);
	
	void deleteUserPersonSkill(Map<String,String> skillInfo);

	
	/*******************************사용자관리 List****************************************/	
	List<Map<String, Object>> UserListMap(Map<String, Object> userList);
	List<Map<String, Object>> readUserInfo(Map<String, String> info);
	List<Map<String, Object>> readUserSkill(Map<String, String> info);

      
}
