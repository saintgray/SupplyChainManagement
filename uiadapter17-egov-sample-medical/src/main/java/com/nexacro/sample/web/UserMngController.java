package com.nexacro.sample.web;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BeanPropertyBindingResult;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.Validator;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nexacro.sample.service.UserMngService;
import com.nexacro.sample.vo.LoginVO;
import com.nexacro.sample.vo.SampleVO;
import com.nexacro.uiadapter17.spring.core.NexacroException;
import com.nexacro.uiadapter17.spring.core.annotation.ParamDataSet;
import com.nexacro.uiadapter17.spring.core.annotation.ParamVariable;
import com.nexacro.uiadapter17.spring.core.data.DataSetRowTypeAccessor;
import com.nexacro.uiadapter17.spring.core.data.NexacroResult;
import com.nexacro17.xapi.data.DataSet;
import com.nexacro17.xapi.tx.PlatformType;

/**
 * <pre>
 * @title   
 * @desc    Login 처리를 한다.
 * -        Controller Login Class
 * @package com.nexacro.Login.web
 * <pre>
 * @author  김태현
 * @since   2019. 9. 19.
 * @version 1.0
 * @see
 * =================== 변경 내역 ==================
 * 날짜			변경자		내용
 * ------------------------------------------------
 * 2019.09.19	김태현		수정
 * 2019.09.27	이미혜		사용자관리 리스트 &상세페이지
 */
@Controller
public class UserMngController {
	private static final Logger logger = LoggerFactory.getLogger(UserMngController.class);
	 
	// Name 정의
	@Autowired
	@Resource(name = "userMngService")
	private UserMngService	userMngService;	
	
	
	//유효성체크
	@Resource
	private Validator	validator;

	//바인딩
    @InitBinder
	public void initBinder(WebDataBinder dataBinder){
		dataBinder.setValidator(this.validator);
	}
     
    //리퀘스트 맵핑
    @RequestMapping(value = "/userregpopup.do")
    public NexacroResult userregpopup(@ParamDataSet(name = "dslist", required = false) Map<String,String> userinfo ,
    		                          @ParamDataSet(name = "dsSkill", required = false) List<Map<String,String>> skillinfo,
    		                          @ParamVariable(name="LoginID") String LoginID
    		                          ) {
    	
        NexacroResult result = new NexacroResult();
        int size = skillinfo.size();
        System.out.println("=====  size : " + size);
        
        //try구문
        try {
              
                userinfo.put("loginID", LoginID);
                
                
                int cnt = userMngService.selectUserPersoncnt(userinfo);
                    
                System.out.println("cnt : " + cnt);
                //System.out.println("birthday : " + userinfo.get("birthday"));
                
                
                    
                if (cnt == 0){
                	System.out.println("insert !!!!!!!!!!!!!! : ");
                  	userMngService.insertUserPersoninfo(userinfo);
                }

                if (cnt > 0){
                	System.out.println("update !!!!!!!!!!!!!! : ");
                   	userMngService.updateUserPersoninfo(userinfo);
                }

                
               //delete구문
                userMngService.deleteUserPersonSkill(userinfo);
                for (int i=0; i<size; i++) {
                	HashMap sample = (HashMap) skillinfo.get(i);
                	sample.put("loginID", LoginID);  
                	
                	int dataRowType = Integer.parseInt(String.valueOf(sample.get(DataSetRowTypeAccessor.NAME)));
            		logger.debug("..... dataRowType >>"+dataRowType);
            		
                   // if (sample instanceof DataSetRowTypeAccessor){
                        if (dataRowType == DataSet.ROW_TYPE_INSERTED){
                        	System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!개인정보 수정하기");
                        	userMngService.insertUserPersonSkill(sample);
                        }
                   // }
                }  	
                
                result.addVariable("result", "S");
        } catch (Exception e){
    	    result.addVariable("result", "F");
        }
        
        return result;
    }
    
    
  //리퀘스트 맵핑
    @RequestMapping(value = "/idcheck.do")
    public NexacroResult idcheck(@ParamVariable(name="LoginID") String LoginID) {	
    	
        NexacroResult resultNr = new NexacroResult();
        Map<String,String> resulthm= new HashMap();
        
        
        Map<String,String> userinfo = new HashMap();
        userinfo.put("id", LoginID);
        
        //try구문
        try {
                int cnt = userMngService.selectUserPersoncnt(userinfo);
                    
                System.out.println("cnt : " + cnt);
                //System.out.println("birthday : " + userinfo.get("birthday"));
                
              //resulthm.put("result",String.valueOf(cnt));                
                if (cnt==0){                	
                	resulthm.put("resultYn","T");
                } else {
                	resulthm.put("resultYn","F");
                }                
        } catch (Exception e){
        	resulthm.put("resultYn","F");      	
        }
        
        resultNr.addDataSet("result", resulthm);
        
        return resultNr;
    }
    
    
    /********************************************사용자관리 코드 LIST**************************************************************/
	@RequestMapping(value="/Userlist.do")
	public NexacroResult UsrListMap(@ParamDataSet(name = "UserSearch", required = false)Map<String, Object> UserList) {
		List<Map<String, Object>> UList=userMngService.UserListMap(UserList);
		NexacroResult result = new NexacroResult();
		result.addDataSet("ds_UserResultList", UList);
		//System.out.println("모든 사용자수?????==========================" + UList);
		return result;
	};

	@RequestMapping(value="/userinfo.do")
	public NexacroResult readUserInfo(@ParamVariable(name="loginID",required=false)String loginID
									 ,@ParamVariable(name="userType",required=false)String userType){
		
		Map<String,String> info=new HashMap<>();
		info.put("loginID", loginID);
		info.put("userType", userType);
				
		
		
		List<Map<String,Object>> UserInfo=userMngService.readUserInfo(info);
		NexacroResult result=new NexacroResult();
		result.addDataSet("ds_Resultlist",UserInfo);		
		result.addDataSet("dsCop",UserInfo);
		
		List<Map<String,Object>> userSkill=userMngService.readUserSkill(info);
		result.addDataSet("ds_skill",userSkill);
		return result;
	
	};
    
}
    