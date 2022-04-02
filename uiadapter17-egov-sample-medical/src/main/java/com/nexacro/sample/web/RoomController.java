package com.nexacro.sample.web;

import java.io.File;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Validator;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.WebApplicationContext;

import com.nexacro.sample.service.RoomService;
import com.nexacro.uiadapter17.spring.core.NexacroException;
import com.nexacro.uiadapter17.spring.core.annotation.ParamDataSet;
import com.nexacro.uiadapter17.spring.core.annotation.ParamVariable;
import com.nexacro.uiadapter17.spring.core.data.NexacroFileResult;
import com.nexacro.uiadapter17.spring.core.data.NexacroResult;
import com.nexacro.uiadapter17.spring.core.util.CharsetUtil;
import com.nexacro17.xapi.tx.PlatformType;




/**
 * <pre>
 * 
 * @title 자료실 페이지
 * @desc 
 * @package com.nexacro.sample.web
 * 
 *          <pre>
 * @author 이선화
 * @since 2019. 11.04
 * @version 1.0
 * 
 * 
 */



@Controller
public class RoomController {
	private static final Logger logger = LoggerFactory.getLogger(RoomController.class);
	
	private static final String SP= File.separator;
	private static final String PATH = "WEB-INF"+SP+"upload";
	
	
	@Autowired 
	private WebApplicationContext appContext;
	
	@Resource(name = "roomService")
	private RoomService roomService;
	
	@Resource
	private Validator validator;
	
	@InitBinder
	public void initBinder (WebDataBinder dataBinder){
		dataBinder.setValidator(this.validator);
	};
	
/*************************************** 자료실 ****************************************/
	// 조회하기
	@RequestMapping(value="/morgueList.do")
	public NexacroResult selectMap(@ParamDataSet(name="ds_Search", required=false)
	Map<String, Object> searchMap){
	
		List<Map<String, Object>> list = roomService.selectFileListMap(searchMap);

		NexacroResult result = new NexacroResult();
		result.addDataSet("ds_fileList",list);
		return result;
	};
	
	
	//게시물 보기
	@RequestMapping(value="/morqueinfo.do")
	public NexacroResult viewMorqueInfo(@ParamVariable(name="userID",required=false)String userID
										,@ParamVariable(name="bd_name",required=false)String bd_name
										,@ParamVariable(name="bd_text",required=false)String bd_text){
		
		Map<String, String> viewinfo= new HashMap<>();
		viewinfo.put("userID", userID);
		viewinfo.put("bd_name", bd_name);
		viewinfo.put("bd_text", bd_text);
		
		List<Map<String, Object>> MorqueInfo=roomService.viewMorqueInfo(viewinfo);
		NexacroResult result = new NexacroResult();
		result.addDataSet("ds_morque",MorqueInfo);
		
		return result;
		
		
	}
	
	
	//게시물 등록하기
		@RequestMapping(value="/morquewrite.do")
		public NexacroResult insertMorqueInfo(@ParamDataSet(name="ds_morque", required=false) Map<String, Object> fileUpdate){
			roomService.ISDMorque(fileUpdate);
			NexacroResult result = new NexacroResult();
			return result;
		};
		
	//게시물 삭제하기 
		@RequestMapping(value="/morquedelete.do")
		public NexacroResult deleteMorqueInfo(@ParamDataSet(name="ds_morque", required=false) Map<String, Object> fileDelete){
			roomService.deleteMorque(fileDelete);
			NexacroResult result = new NexacroResult();
			return result;
		};
	
	
}















