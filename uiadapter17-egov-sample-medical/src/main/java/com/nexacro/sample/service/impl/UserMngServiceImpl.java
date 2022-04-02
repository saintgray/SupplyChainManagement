package com.nexacro.sample.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nexacro.sample.service.UserMngService;
import com.nexacro.sample.service.impl.ibatis.UserMngDAO;
import com.nexacro.sample.vo.LoginVO;
import com.nexacro.uiadapter17.spring.core.annotation.ParamDataSet;
import com.nexacro.uiadapter17.spring.core.data.DataSetRowTypeAccessor;
import com.nexacro.uiadapter17.spring.core.data.NexacroResult;
import com.nexacro17.xapi.data.DataSet;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 
 * <pre>
 * @desc    Login 처리를 한다.
 * @package com.nexacro.Login.service.impl
 * <pre>
 * 
 * @author  김태현	
 * @since   2019. 9. 19.
 * @version 1.0
 * @see
 * =================== 변경 내역 ==================
 * 날짜			변경자		내용
 * ------------------------------------------------
 * 2019. 8. 20.	김태현	           내용수정
 * 2019.09.27	이미혜		사용자 리스트&상세정보 
 */   
@Service("userMngService")
//@Service
public class UserMngServiceImpl extends EgovAbstractServiceImpl implements UserMngService {
	
    @Resource(name = "userMngDAO")
    // Name 정의
    private UserMngDAO userMngDAO;
    
    
    public int selectUserPersoncnt(Map<String,String> userinfo) {
    	//System.out.println("UserLogInServiceImpl userInfo id : " + userinfo.get("id"));
    	//System.out.println("UserLogInServiceImpl userInfo password : " + userinfo.get("password"));
       	return userMngDAO.selectUserPersoncnt(userinfo);
    }

    
    
    public void insertUserPersoninfo(Map<String,String> userinfo) {
    	//System.out.println("UserLogInServiceImpl userInfo id : " + userInfo.get("id"));
    	//System.out.println("UserLogInServiceImpl userInfo password : " + userInfo.get("password"));
       	userMngDAO.insertUserPersonInfo(userinfo);   
        return;
    }
    
    

                
    public void updateUserPersoninfo(Map<String,String> userinfo) {
    	//System.out.println("UserLogInServiceImpl userInfo id : " + userInfo.get("id"));
    	//System.out.println("UserLogInServiceImpl userInfo password : " + userInfo.get("password"));	
    	userMngDAO.updateUserPersonInfo(userinfo);             
        return;
    }
    

    @Override
    public void insertUserPersonSkill(Map<String,String> skillInfo) {
    	//System.out.println("UserLogInServiceImpl userInfo id : " + userInfo.get("id"));
    	//System.out.println("UserLogInServiceImpl userInfo password : " + userInfo.get("password"));    	
    	userMngDAO.insertUserPersonSkill(skillInfo);             
        return;
    }



    
    
    
    @Override
    public void deleteUserPersonSkill(Map<String,String> skillInfo) {
    	//System.out.println("UserLogInServiceImpl userInfo id : " + userInfo.get("id"));
    	//System.out.println("UserLogInServiceImpl userInfo password : " + userInfo.get("password"));    	
    	userMngDAO.deleteUserPersonSkill(skillInfo);             
        return;
    }

    /*******************************사용자관리 List****************************************/
	@Override
	public List<Map<String, Object>> UserListMap(Map<String, Object> userList) {
		return userMngDAO.UserListMap(userList);
	}

	@Override
	public List<Map<String, Object>> readUserInfo(Map<String, String> info) {
		return userMngDAO.readUserInfo(info);
	}

	@Override
	public List<Map<String, Object>> readUserSkill(Map<String, String> info) {
		return userMngDAO.readUserSkill(info);
	}


    
}   
