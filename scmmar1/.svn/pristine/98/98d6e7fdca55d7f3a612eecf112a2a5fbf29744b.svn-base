package kr.happyjob.study.scm.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.scm.user.model.UserRegData;
import kr.happyjob.study.scm.user.service.UserInfoService;

@Controller
@RequestMapping("/scm/")
public class UserInfoController {
	
	
	private UserInfoService uiService;
	
	public UserInfoController() {
		
	}
	
	
	@Autowired
	public UserInfoController(UserInfoService uiService) {
		
		this.uiService = uiService;
	}



	@GetMapping("userinfo.do")
	public String initUserInfoList(Model model){
		return "scm/usermng/usermngmain";
	}
	
	@PostMapping("userinfo/manage")
	@ResponseBody
	public int manageUser(String action, UserRegData data){
		
		
		int result=0;
		
		System.out.println("action >> "+action);
		
		try{
				switch(action){
				
					case "UPDATE" :
						result=uiService.updateUser(data);
						break;
					case "DELETE" :
						result=uiService.deleteUser(data.getLoginID());
						break;
					case "REGISTER" :
						result=uiService.insertUser(data);
						break;
				}
		}catch(Exception e){
			
			e.printStackTrace();
		}
		
		
		
		return result;
		
	}
	
	
	

}
