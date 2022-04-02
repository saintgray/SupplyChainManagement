package kr.happyjob.study.scm.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.happyjob.study.scm.user.service.UserInfoService;

@Controller
@RequestMapping("/scm/userinfo/")
public class UserFormController {
	
	
	private UserInfoService uiService;
	
	public UserFormController() {
	
	}

	@Autowired
	public UserFormController(UserInfoService uiService) {

		this.uiService = uiService;
	}


	@RequestMapping("getForm")
	@PostMapping
	public String initUserForm(String action, String userID, Model model){
		
		if(!action.equals("REGISTER")){
			
			model.addAttribute("info", uiService.getUserInfo(userID));
			
		}
		
		
		model.addAttribute("action", action);
		
		
		
		
		
		return "scm/usermng/system/userForm";
		
	}

}
