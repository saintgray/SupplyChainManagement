package com.nexacro.sample.web;

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

import com.nexacro.sample.service.CommonService;
import com.nexacro.uiadapter17.spring.core.NexacroException;
import com.nexacro.uiadapter17.spring.core.annotation.ParamDataSet;
import com.nexacro.uiadapter17.spring.core.annotation.ParamVariable;
import com.nexacro.uiadapter17.spring.core.data.NexacroResult;

import com.nexacro.sample.vo.CommonVO;

/**
 * <pre>
 * @title   
 * @desc    공통 모듈 처리.
 * -        Controller Login Class
 * @package com.nexacro.sample.web
 * <pre>
 * @author  황기현
 * @since   2019. 9. 9.
 * @version 1.0
 * @see
 * =================== 변경 내역 ==================
 * 날짜			변경자		내용
 * ------------------------------------------------
 * 2019. 9. 9.	황기현	       최초작성
 */
@Controller
public class CommonController {
	private static final Logger logger = LoggerFactory.getLogger(CommonController.class);
	   
	// Name 정의
	@Autowired
	@Resource(name = "commonService")
	private CommonService	commonService;	
	   
     
    @RequestMapping(value = "/selectcommcdcombo.do")
    public NexacroResult selectcommcdcombo(@ParamVariable(name="grpCd") String grpCd) {	

    	List<CommonVO> commcdlist = commonService.selectcommcdcombo(grpCd);
    	
        NexacroResult result = new NexacroResult();
        result.addDataSet("dsList", commcdlist);
        
        return result;
    }
    
    
    
}
