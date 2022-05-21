package kr.happyjob.study.scm.user.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.happyjob.study.scm.user.exception.UserExistException;
import kr.happyjob.study.scm.user.model.PageInfo;
import kr.happyjob.study.scm.user.model.UserDetail;
import kr.happyjob.study.scm.user.model.UserRegData;
import kr.happyjob.study.scm.user.service.UserInfoService;

@RestController
@RequestMapping("/scm/vue")
public class VueUserController {

	private final Logger logger = LogManager.getLogger(this.getClass());

	private UserInfoService uiService;

	public VueUserController() {

	}

	@Autowired
	public VueUserController(UserInfoService uiService) {
		this.uiService = uiService;
	}


	@GetMapping("/users")
	public Map<String, Object> getUserList(PageInfo param, HttpServletResponse resp) throws IOException {

		Map<String, Object> result = null;

		try {
			result = new HashMap<String, Object>();
			result.put("page", uiService.getUserList(param));
		} catch (Exception e) {
			resp.sendError(500);

		}
		return result;
	}


	@GetMapping("/user/{id}")
	public Map<String, Object> getUser(@PathVariable String id, HttpServletResponse resp) throws IOException {
		
		Map<String, Object> result = new HashMap<>();

		UserDetail detail = null;
		try{
			detail = uiService.getUserInfo(id, null);
			
		}catch(Exception e){
			resp.sendError(500);
		}
		result.put("info",detail);
		return result;
	}
	
	@GetMapping("/user/{id}")
	public Map<String,Object> getUser(String action, @PathVariable(value="id") String userID, HttpServletResponse resp) throws IOException{
		
		
		Map<String, Object> result=new HashMap<>();
		UserDetail detail=null;
		try{
			detail=uiService.getUserInfo(userID, null);
			if(detail==null){
				resp.setStatus(903);
			}else{
				result.put("info", detail);
//			    test resp send Error
//				resp.setStatus(903);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return result;
	}

	@PostMapping("/user")
	public void insertUser(UserRegData data, HttpServletResponse resp){
		int result=0;
		
		try{
			result=uiService.insertUser(data);
			if(result==1){
				resp.setStatus(200);
			}
		}catch(Exception e){
			if(e instanceof UserExistException){
				resp.setStatus(903);
			}else{
				resp.setStatus(500);
			}
		}
	}
	
	@DeleteMapping("/user/{id}")
	public void deleteUser(@PathVariable String id, HttpServletResponse resp){
		
		int result=0;
		
		try{
			result=uiService.deleteUser(id);
			if(result==0){
				resp.setStatus(903);
			}else if(result==1){
				resp.setStatus(200);
			}else{
				resp.setStatus(500);
			}
		}catch(Exception e){
			resp.setStatus(500);
		}
	}
}
