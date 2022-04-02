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

import com.nexacro.sample.service.UserLogInService;
import com.nexacro.sample.vo.LoginVO;
import com.nexacro.uiadapter17.spring.core.NexacroException;
import com.nexacro.uiadapter17.spring.core.annotation.ParamDataSet;
import com.nexacro.uiadapter17.spring.core.data.NexacroResult;

/**
 * <pre>
 * 
 * @title
 * @desc Login 처리를 한다. - Controller Login Class
 * @package com.nexacro.Login.web
 * 
 *          <pre>
 * @author 황기현
 * @since 2019. 8. 20.
 * @version 1.0
 * @see =================== 변경 내역 ================== 날짜 변경자 내용
 *      ------------------------------------------------ 2019. 8. 20. 황기현 최초작성
 */
@Controller
public class UserLogInController {
	private static final Logger logger = LoggerFactory.getLogger(UserLogInController.class);

	// Name 정의
	@Autowired
	@Resource(name = "userLogInService")
	private UserLogInService userLogInService;

	@Resource
	private Validator validator;
	// 유효성 검사?

	@InitBinder
	public void initBinder(WebDataBinder dataBinder) {
		dataBinder.setValidator(this.validator);
	}

	@RequestMapping(value = "/login.do")
	// public NexacroResult login(@ParamDataSet(name = "dssearch", required =
	// false) LoginVO searchVo) {
	public NexacroResult login(@ParamDataSet(name = "dsSearch", required = false) Map<String, String> gdsUser) {
		// 넘겨주는 이름은 dsSearch이고 받는 값은 gdsUser(map)
		
		Map<String, String> user = userLogInService.login(gdsUser);
		NexacroResult result = new NexacroResult();
		result.addDataSet("dsList", user);
		return result;
	}
	
	@RequestMapping(value = "/check_id.do")
	public NexacroResult check_id(@ParamDataSet(name = "ds_userinfo", required = false) 
	Map<String, String> gdscheck_id) {
		Map<String, String> user = userLogInService.check_id(gdscheck_id);
		NexacroResult result = new NexacroResult();
		result.addDataSet("dsList", user);
		return result;
	}

	@RequestMapping(value = "/check_email.do")
	public NexacroResult check_email(@ParamDataSet(name = "ds_userinfo", required = false) 
	Map<String, String> gdscheck_email) {
		Map<String, String> user = userLogInService.check_email(gdscheck_email);
		NexacroResult result = new NexacroResult();
		result.addDataSet("dsList", user);
		return result;
	}

	@RequestMapping(value = "/find.do")
	public NexacroResult findId(@ParamDataSet(name = "ds_phone_form", required = false) 
	Map<String, String> findId) {
		Map<String, String> user = userLogInService.find(findId);
		NexacroResult result = new NexacroResult();
		result.addDataSet("dsList", user);
		return result;
	}	

	@RequestMapping(value="register.do")
	public NexacroResult insertUser(@ParamDataSet(name="ds_userinfo", required=false) 
	Map<String, String> userinfo){
		userLogInService.register(userinfo);
		
		Map<String, String> user = new HashMap<>();
		user.put("check", "success");
		NexacroResult result = new NexacroResult();
		result.addDataSet("dsList", user);
		return result;
	};
	
	@RequestMapping(value="modify.do")
	public NexacroResult modify_info(@ParamDataSet(name="ds_userinfo", required=false) 
	Map<String, String> userinfo){
		userLogInService.modify(userinfo);
		
		Map<String, String> user = new HashMap<>();
		user.put("check", "success");
		NexacroResult result = new NexacroResult();
		result.addDataSet("dsList", user);
		return result;
	};

	@RequestMapping(value="delete.do")
	public NexacroResult delete_info(@ParamDataSet(name="ds_userinfo", required=false) 
	Map<String, String> userinfo){
		userLogInService.delete(userinfo);
		Map<String, String> user = new HashMap<>();
		user.put("check", "success");
		NexacroResult result = new NexacroResult();
		result.addDataSet("dsList", user);
		return result;
	};
	@RequestMapping(value="login_use.do")
	public NexacroResult use_start(@ParamDataSet(name="gdsUserInfo", required=false) 
	Map<String, String> userinfo){
		userLogInService.use_start(userinfo);
		NexacroResult result = new NexacroResult();
		return result;
	};
	@RequestMapping(value="login_out.do")
	public NexacroResult use_end(@ParamDataSet(name="gdsUserInfo", required=false) 
	Map<String, String> userinfo){
		userLogInService.use_end(userinfo);
		userLogInService.sales_update(userinfo);
		NexacroResult result = new NexacroResult();
		return result;
	};
	
	@RequestMapping(value="call_food.do")
	public NexacroResult call_food(@ParamDataSet(name="gdsUserInfo", required=false) 
	Map<String, Object> userinfo){
		Map<String, Object> user = userLogInService.call_food(userinfo);
		Map<String, Object> user2 = userLogInService.call_start_date(userinfo);
		
		NexacroResult result = new NexacroResult();
		result.addDataSet("dsList", user);
		result.addDataSet("dsList2", user2);
		return result;
	};
	
	@RequestMapping(value="re_insert.do")
	public NexacroResult re_insert(@ParamDataSet(name="ds_result", required=false) 
	Map<String, Object> userinfo){
		userLogInService.re_insert(userinfo);
	
		NexacroResult result = new NexacroResult();
		return result;
	};
	
	@RequestMapping(value = "/loginvo.do")
	// public NexacroResult login(@ParamDataSet(name = "dssearch", required =
	// false) LoginVO searchVo) {
	public NexacroResult loginvo(@ParamDataSet(name = "dsSearch", required = false) Map<String, String> gdsUser) {

		LoginVO user = userLogInService.loginvo(gdsUser);

		// System.out.println("user.toString() : " + user.toString());

		NexacroResult result = new NexacroResult();
		result.addDataSet("dsList", user);

		return result;
	}

	/**
	 * validate
	 * 
	 * @param modifyList
	 * @throws NexacroException
	 */
	private void validate(LoginVO userVo) throws NexacroException {
		BindingResult bindingResult = null;
		bindingResult = new BeanPropertyBindingResult(userVo, "userVO");
		validator.validate(userVo, bindingResult);
		if (bindingResult.hasErrors()) {
			String errorMessages = getErrorMessages(bindingResult);

			NexacroException nexacroException = new NexacroException(errorMessages);
			nexacroException.setErrorCode(NexacroException.DEFAULT_ERROR_CODE);
			nexacroException.setErrorMsg(errorMessages);

			throw nexacroException;
		}
	}

	/**
	 * getErrorMessages
	 * 
	 * @param bindingResult
	 */
	private String getErrorMessages(BindingResult bindingResult) {
		StringBuffer sb = new StringBuffer();

		for (ObjectError error : bindingResult.getAllErrors()) {
			sb.append(error.getDefaultMessage()).append("\n");
		}

		return sb.toString();
	}
}
