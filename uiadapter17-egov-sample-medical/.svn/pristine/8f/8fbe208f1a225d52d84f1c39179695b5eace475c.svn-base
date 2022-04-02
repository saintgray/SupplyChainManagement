package com.nexacro.sample.service.impl.ibatis;

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
 * @author  김태현
 * @since   2019. 9. 19.
 * @version 1.0
 * @see
 * =================== 변경 내역 ==================
 * 날짜			변경자		내용
 * ------------------------------------------------
 * 2019. 9. 19.	김태현	       내용변경
 */  
@Repository("userMngDAO")
public class UserMngDAO extends NexacroIbatisAbstractDAO {

	
    //Map처리 추가 
    public int selectUserPersoncnt(Map<String,String> userinfo) {
    	//System.out.println("UserLogInDAO userinfo id : " + userinfo.get("id"));
    	//System.out.println("UserLogInDAO userinfo password : " + userinfo.get("password"));
       	//(select("user.login", userInfo)
    	return (int) select("usermng.selectUserPersoncnt", userinfo);
    }   
	
	
	
    //Map처리 추가 
    public void insertUserPersonInfo(Map<String,String> userInfo) {
    	//System.out.println("UserLogInDAO userInfo id : " + userInfo.get("id"));
    	//System.out.println("UserLogInDAO userInfo password : " + userInfo.get("password"));    	
    	//(select("user.login", userInfo)
    	insert("usermng.insertpersoninfo", userInfo);
    	insert("usermng.insertUserCareer",userInfo);    	        
    	return;
    }   
	
			
	
    //Map처리 추가 
    public void updateUserPersonInfo(Map<String,String> userInfo) {
    	//System.out.println("UserLogInDAO userInfo id : " + userInfo.get("id"));
    	//System.out.println("UserLogInDAO userInfo password : " + userInfo.get("password"));    	
    	//(select("user.login", userInfo)
    	update("usermng.updatepersoninfo", userInfo);
    	update("usermng.updateUserCareer", userInfo);    	
    	return;
    }   
	
	
	
    //Map처리 추가 
    public void insertUserPersonSkill(Map<String,String> skillInfo) {
    	//System.out.println("UserLogInDAO userInfo id : " + userInfo.get("id"));
    	//System.out.println("UserLogInDAO userInfo password : " + userInfo.get("password"));    	
    	//(select("user.login", userInfo)
    	insert("usermng.insertpersonskill", skillInfo);
    	return;
    }    
    

    
    

    
    
  //Map처리 추가 
    public void deleteUserPersonSkill(Map<String,String> skillInfo) {
    	//System.out.println("UserLogInDAO userInfo id : " + userInfo.get("id"));
    	//System.out.println("UserLogInDAO userInfo password : " + userInfo.get("password"));    	
    	//(select("user.login", userInfo)
    	insert("usermng.deletepersonskill", skillInfo);    	
    	return;
    }

    
	/********************************* 사용자관리 ************************************************/
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> UserListMap(Map<String, Object> userList) {
		return (List<Map<String, Object>>) list("usermng.UserListMap", userList);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> readUserInfo(Map<String, String> info) {
		return (List<Map<String, Object>>) list("usermng.readUserInfo",info);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> readUserSkill(Map<String, String> info) {
		return (List<Map<String, Object>>) list("usermng.readUserCareer",info);
	}



    
}