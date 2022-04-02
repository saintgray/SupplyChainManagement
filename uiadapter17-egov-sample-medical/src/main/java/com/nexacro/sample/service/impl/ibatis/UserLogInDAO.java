package com.nexacro.sample.service.impl.ibatis;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.nexacro.sample.vo.LoginVO;
import com.nexacro.spring.dao.ibatis.NexacroIbatisAbstractDAO;

/**
 * <pre>
 * @desc    Login 처리를 한다.
 * @package com.nexacro.Login.service.impl.ibatis
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
@Repository("userLogInDAO")
public class UserLogInDAO extends NexacroIbatisAbstractDAO {

    //Map처리 추가 
    public Map<String,String>  login(Map<String,String> userInfo) {
    	//System.out.println("UserLogInDAO userInfo id : " + userInfo.get("id"));
    	//System.out.println("UserLogInDAO userInfo password : " + userInfo.get("password"));
    	
    	return (Map<String,String>) select("user.login", userInfo);
    }    
    
    //Map처리 추가 
    public Map<String,String> check_id(Map<String,String> userInfo) {
    	return (Map<String,String>) select("regi.check_id", userInfo);
    } 
    
    public Map<String,String> check_email(Map<String,String> userInfo) {
    	return (Map<String,String>) select("regi.check_email", userInfo);
    } 

    public Map<String,String> find(Map<String,String> userInfo) {
    	return (Map<String,String>) select("regi.find", userInfo);
    } 

    public Map<String,Object> call_food(Map<String,Object> userInfo) {
    	return (Map<String,Object>) select("using.food", userInfo);
    } 
    
    public Map<String,Object> call_start_date(Map<String,Object> userInfo) {
    	return (Map<String,Object>) select("using.date", userInfo);
    }
    
    //Map처리 추가 
    public LoginVO loginvo(Map<String,String> userInfo) {
    	//System.out.println("UserLogInDAO userInfo id : " + userInfo.get("id"));
    	//System.out.println("UserLogInDAO userInfo password : " + userInfo.get("password"));
    	
    	return  (LoginVO) select("user.loginvo", userInfo);
    }   
    
	public void register(Map<String, String> userinfo){
		insert("regi.insertUserData", userinfo);
		return;
	}
	
	public void modify(Map<String, String> userinfo){
		update("regi.modify", userinfo);
		return;
	}
	
	public void use_start(Map<String, String> userinfo){
		update("user.start", userinfo);
		return;
	}
	
	public void use_end(Map<String, String> userinfo){
		update("user.end", userinfo);
		return;
	}
	
	public void delete(Map<String, String> userinfo){
		delete("regi.delete", userinfo);
		return;
	}
	public void sales_update(Map<String, String> userinfo){
	    update("using.sales_update", userinfo); 
	}
	
	
    public Map<String, Object> re_search(Map<String, Object> userInfo) {
    	return (Map<String, Object>) select("using.search", userInfo);
    }  
	public void re_insert(Map<String, Object> userinfo){
		update("using.re_update", userinfo);
	}
/*	public void finish_update(Map<String, Object> call_code){
		update("using.finish", call_code);
	}*/
}
