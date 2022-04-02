package com.nexacro.sample.service.impl;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.nexacro.sample.service.UserLogInService;
import com.nexacro.sample.service.impl.ibatis.UserLogInDAO;
import com.nexacro.sample.vo.LoginVO;

import com.nexacro.uiadapter17.spring.core.data.DataSetRowTypeAccessor;
import com.nexacro17.xapi.data.DataSet;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 
 * <pre>
 * @desc    Login 처리를 한다.
 * @package com.nexacro.Login.service.impl
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
@Service("userLogInService")
//@Service
public class UserLogInServiceImpl extends EgovAbstractServiceImpl implements UserLogInService {

    @Resource(name = "userLogInDAO")
    // Name 정의
    private UserLogInDAO userLogInDAO;

      
    @Override
    public Map<String,String> login(Map userInfo) {
    	Map<String,String> returnUser = new HashMap(); 
    	
    	//System.out.println("UserLogInServiceImpl userInfo id : " + userInfo.get("id"));
    	//System.out.println("UserLogInServiceImpl userInfo password : " + userInfo.get("password"));
    	
    	returnUser = userLogInDAO.login(userInfo);
             
        return returnUser;
    }
    
    @Override
    public Map<String,String> check_id(Map userInfo) {
    	Map<String,String> returnUser = new HashMap(); 
    	returnUser = userLogInDAO.check_id(userInfo); 
        return returnUser;
    }
    
    @Override
    public Map<String,String> check_email(Map userInfo) {
    	Map<String,String> returnUser = new HashMap(); 
    	returnUser = userLogInDAO.check_email(userInfo); 
        return returnUser;
    }

    @Override
    public Map<String,String> find(Map userInfo) {
    	Map<String,String> returnUser = new HashMap(); 
    	returnUser = userLogInDAO.find(userInfo); 
        return returnUser;
    }
    
	public void register(Map<String, String> userinfo){
		userLogInDAO.register(userinfo);	
	}
    
	public void modify(Map<String, String> userinfo){
		userLogInDAO.modify(userinfo);	
	}
	public void delete(Map<String, String> userinfo){
		userLogInDAO.delete(userinfo);	
	}
	public void use_start(Map<String, String> userinfo){
		userLogInDAO.use_start(userinfo);	
	}
	public void use_end(Map<String, String> userinfo){
		userLogInDAO.use_end(userinfo);	
	}
	public void sales_update(Map<String, String> userinfo){
		userLogInDAO.sales_update(userinfo);	
	}
	@Override
	public Map<String, Object> call_food(Map<String, Object> userInfo) {
    	Map<String,Object> returnUser = new HashMap(); 
    	returnUser = userLogInDAO.call_food(userInfo); 
        return returnUser;
	} 
	@Override
	public Map<String, Object> call_start_date(Map<String, Object> userInfo) {
    	Map<String,Object> returnUser = new HashMap(); 
    	returnUser = userLogInDAO.call_start_date(userInfo); 
    	String test = (String) returnUser.get("start");
    	SimpleDateFormat format = new SimpleDateFormat("dd-HH.mm");
    	String end_time = format.format(System.currentTimeMillis());
    	
    	returnUser.put("end_date", System.currentTimeMillis());
    	
    	String[] str1 = test.split("-");
     	String[] str2 = end_time.split("-");
     	
     	if(str1[0].equals(str2[0])){
     		Double num1 = Double.parseDouble(str1[1]);
     		Double num2 = Double.parseDouble(str2[1]);
     		int result = (int) Math.round(((num2-num1)*15))*100 ;
     		// System.out.println(result);
     		returnUser.put("charge", result); 
     	}else{
     		int day1 = Integer.parseInt(str1[0]);
     		int day2 = Integer.parseInt(str2[0]);
     		Double num1 = Double.parseDouble(str1[1]);
     		Double num2 = Double.parseDouble(str2[1]);
     		int result = (int) Math.round(((num2-num1)*15))*100 + 36000*(day2-day1) ;
     		// System.out.println(result);
     		returnUser.put("charge", result); 
     	}
        return returnUser;
	} 
	
	@Override
	public void re_insert(Map<String, Object> userinfo) {
		// TODO Auto-generated method stub
    	Map<String, Object> call_code = new HashMap();
    	
    	userLogInDAO.re_insert(userinfo) ; // 값 추가 
    	call_code = userLogInDAO.re_search(userinfo); // using table에서 자리번호, 코드 호출
    	
    	// userLogInDAO.finish_update(call_code) ; // pcroom_local 수정용, 관리자 팀에서 미구현이라고 함.
	}
	
	
    @Override
    public LoginVO loginvo(Map userInfo) {
    	LoginVO returnUser = userLogInDAO.loginvo(userInfo);
        return returnUser;
    }    
}
