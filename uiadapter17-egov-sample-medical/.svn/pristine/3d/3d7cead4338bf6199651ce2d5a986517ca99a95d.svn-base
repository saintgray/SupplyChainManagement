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
 * @author  황기현
 * @since   2019. 8. 20.
 * @version 1.0
 * @see
 * =================== 변경 내역 ==================
 * 날짜			변경자		내용
 * ------------------------------------------------
 * 2019. 8. 20.	황기현	       최초작성
 */
public interface UserLogInService {

	Map<String,String> login(Map<String,String> userInfo);
	
	Map<String,Object> call_food(Map<String,Object> userInfo);
	Map<String,Object> call_start_date(Map<String,Object> userInfo);
	
	Map<String,String> check_id(Map<String,String> userInfo);
	Map<String,String> check_email(Map<String,String> userInfo);
	Map<String,String> find(Map<String,String> userInfo);
	LoginVO loginvo(Map<String,String> userInfo);
	void register(Map<String, String> userinfo);
	void modify(Map<String, String> userinfo);
	void delete(Map<String, String> userinfo);
	void use_start(Map<String, String> userinfo);
	void use_end(Map<String, String> userinfo);
	void sales_update(Map<String, String> userinfo);
	
	void re_insert(Map<String, Object> userinfo);
}
