package kr.happyjob.study.scm.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.happyjob.study.scm.user.model.PageInfo;
import kr.happyjob.study.scm.user.service.UserInfoService;

@Controller
@RequestMapping("/scm/userinfo/userlist")
public class UserListContoller {
	
	
	
	
	private UserInfoService uiService;
	
	
	public UserListContoller() {
		
	}
	
	
	@Autowired
	public UserListContoller(UserInfoService uiService) {
		super();
		this.uiService = uiService;
	}



	@PostMapping
	public String getUserList(Model model, PageInfo param){
		
		System.out.println(param.getKeyword());
		
		try{
			model.addAttribute("page", uiService.getUserList(param));
		}catch(Exception e){
			e.printStackTrace();
		}
		
		
		
		
		
		return  "scm/usermng/system/userList";
	}

}
