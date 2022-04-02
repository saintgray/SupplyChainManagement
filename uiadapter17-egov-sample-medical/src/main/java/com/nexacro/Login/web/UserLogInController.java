package com.nexacro.Login.web;

import java.util.List;
import java.util.Map;

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

import com.nexacro.Login.service.UserLogInService;
import com.nexacro.Login.vo.UserVO;
import com.nexacro.uiadapter17.spring.core.NexacroException;
import com.nexacro.uiadapter17.spring.core.annotation.ParamDataSet;
import com.nexacro.uiadapter17.spring.core.data.NexacroResult;

/**
 * <pre>
 * @title   
 * @desc    Login 처리를 한다.
 * -        Controller Login Class
 * @package com.nexacro.Login.web
 * <pre>
 * @author  황기현
 * @since   2019. 8. 20.
 * @version 1.0
 * @see
 * =================== 변경 내역 ==================
 * 날짜			변경자		내용
 * ------------------------------------------------
 * 2019. 8. 20.	황기현	       최초작성
 */
@Controller
public class UserLogInController {
	private static final Logger logger = LoggerFactory.getLogger(UserLogInController.class);
	
	// Name 정의
	//@Autowired
	@Resource(name = "userLogInService")
	private UserLogInService	userLogInService;	
	
	@Resource
	private Validator	validator;

    @InitBinder
	public void initBinder(WebDataBinder dataBinder){
		dataBinder.setValidator(this.validator);
	}
     
    @RequestMapping(value = "/login2.do")
	public NexacroResult login(@ParamDataSet(name = "ds_search", required = false) UserVO searchVo) {
        
    	System.out.println("searchVo.getUserPassword() : " + searchVo.getUserPassword());
    	 
        UserVO user = userLogInService.login(searchVo);
        
        NexacroResult result = new NexacroResult();
        result.addDataSet("dsList", user);
        
        return result;
    }
    

	/**
	 * validate
	 * @param modifyList
	 * @throws NexacroException
	 */
	private void validate(UserVO userVo) throws NexacroException {
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
