package com.nexacro.sample.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nexacro.sample.service.testService;
import com.nexacro.uiadapter17.spring.core.annotation.ParamDataSet;
import com.nexacro.uiadapter17.spring.core.data.NexacroResult;

/**
 * <pre>
 * @title   
 * @desc    제공된 예제는 샘플용으로 작성된 코드로 참고용으로만
 *          사용하시기 바랍니다.
 * -        Controller Sample Class
 * @package com.nexacro.sample.web
 * <pre>
 * @author  TOBESOFT
 * @since   2017. 11. 8.
 * @version 1.0
 * @see
 * =================== 변경 내역 ==================
 * 날짜			변경자		내용
 * ------------------------------------------------
 * 2017. 11. 8.		TOBESOFT	최초작성
 */
@Controller
public class testController {
	private Logger log = LoggerFactory.getLogger(testController.class);
	
    @Resource(name = "nexacrotestService")
    // Name 정의
    private testService nexacrotestService;
    
   //////////////////
    
    @RequestMapping(value = "/selectcrud.do")
	public NexacroResult testselect(@ParamDataSet(name = "dstest", required = false) Map<String,String> dstest) {

		List<Map<String,Object>> sampleList = nexacrotestService.testselect(dstest);

		NexacroResult result = new NexacroResult();
		result.addDataSet("dstest", sampleList);

		return result;
	}
    
    @RequestMapping(value = "/updatecrud.do")
   	public NexacroResult updatetest(@ParamDataSet(name = "dstest") List<Map<String,Object>> dstest) {
       	   System.out.println("ddddddddddddddddddddddddddddddddwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww");
       	   nexacrotestService.updatetest(dstest);
           NexacroResult result = new NexacroResult();
           return result;
    }
    
    @RequestMapping(value = "/gogo.do")
   	public String test1() {

   		return "/pr/aaa";
   	}
    
}
