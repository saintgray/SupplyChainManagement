package com.nexacro.sample.web;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nexacro.Login.service.UserLogInService;
import com.nexacro.Login.vo.UserVO;
import com.nexacro.sample.vo.PersonListDTO;
import com.nexacro.sample.service.PersonListService;
import com.nexacro.uiadapter17.spring.core.NexacroException;
import com.nexacro.uiadapter17.spring.core.annotation.ParamDataSet;
import com.nexacro.uiadapter17.spring.core.data.NexacroResult;
import com.nexacro17.xapi.data.DataSet;


@Controller
public class PersonListController {
	private static final Logger logger = LoggerFactory.getLogger(PersonListController.class);
	
	// Name 정의
	@Autowired
	private PersonListService service;
	

    @RequestMapping(value = "personList.do")
	public NexacroResult searchList(@ParamDataSet(name = "dsSearch", required = false) Map<String, String> map) {
      System.out.println("파라미터"+map);
    	
    	
       List<PersonListDTO> dto = service.searchList(map);
        
        NexacroResult result = new NexacroResult();
  
        
        result.addDataSet("ds_Resultlist", dto);
      
       
        return result;
       
    }
    

}
