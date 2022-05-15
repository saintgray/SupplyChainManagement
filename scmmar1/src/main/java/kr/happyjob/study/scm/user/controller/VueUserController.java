package kr.happyjob.study.scm.user.controller;

import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.happyjob.study.scm.user.model.PageInfo;
import kr.happyjob.study.scm.user.model.UserDetail;
import kr.happyjob.study.scm.user.service.UserInfoService;

@RestController
@RequestMapping("/scm")
public class VueUserController {

	private final Logger logger = LogManager.getLogger(this.getClass());
	
	private UserInfoService uiService;

	public VueUserController() {
	
	}
	
	@Autowired
	public VueUserController(UserInfoService uiService) {
		this.uiService = uiService;
	}

	@PostMapping("/vue/userList")
	public Map<String,Object> getUserList(PageInfo param){
		
		logger.info("+ Vue getUserList initiated....");
		
		Map<String,Object> result= null;
		
		try{
			result=new HashMap<String, Object>();
			result.put("page",uiService.getUserList(param));
		}catch(Exception e){
			e.printStackTrace();
		}
		return  result;
	}
	
	
	
	@PostMapping("/vue/getForm")
	public Map<String,Object> initUserForm(String action, String userID){
		
		
		Map<String, Object> result=new HashMap<>();
		
		
		if(!action.equals("NEW")){
			
			
			result.put("info", uiService.getUserInfo(userID,null));

		}else{
			result.put("info", new UserDetail());
		}
		

		return result;
		
	}

	
	
	@PostMapping("/vue/userinfo/{userID}")
	public Map<String, Object> getUserInfo(@PathVariable("userID") String id){
		
		Map<String, Object> result= new HashMap<>();
		
		UserDetail detail=null;
		
		detail=uiService.getUserInfo(id,null);
		
		if(detail!=null){
			result.put("userinfo", detail);
		}
		return result;
	}
}
