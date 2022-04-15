package kr.happyjob.study.scmStandard.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.scmStandard.dao.QnaDao;
import kr.happyjob.study.scmStandard.model.QnaModel;
import kr.happyjob.study.scmStandard.service.QnaService;

@Controller
@RequestMapping("/scmStandard/")
public class QnaController {

	@Autowired
	QnaService qnaService;
	
	// set Logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	// Get class name for logger
	private final String className = this.getClass().toString();
	

	@RequestMapping("qna.do")
	public String Qna(@RequestParam Map<String, Object> paramMap){
		
		logger.info("+ Start " + className + ".initComnCod");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".initComnCod");
		
		return "/scmStandard/Qna";
	}
	
	@RequestMapping("qnaSave.do")
	@ResponseBody
	public Map<String, Object> qnaSave(Model model,@RequestParam Map<String,Object> paramMap,HttpServletRequest request,
			HttpServletResponse response,HttpSession session) throws Exception{
		logger.info("+Start"+className+"qnaSave");
		logger.info("- paramMap"+paramMap);
		
		
		int resultNum = qnaService.insertQna(paramMap);
		
		String result = "";
		String resultMsg  = "";
		
		Map<String,Object> resultMap = new HashMap<String, Object>();
		
		
		if(resultNum>0){
			 result ="SUCCESS";
			 resultMsg="저장되었습니다";
			 resultMap.put("result",result);
			resultMap.put("resultMsg", resultMsg);
		}
		
		logger.info("-End"+className+"qnaSave");
		return resultMap;
	}
	
	@RequestMapping("qnaList.do")
	public String qnaList(Model model,@RequestParam Map<String,Object> paramMap,HttpServletRequest request,
			HttpServletResponse response,HttpSession session) throws Exception{
		
		logger.info("+start"+className+"qnaList");
		logger.info("-paramMap"+paramMap);
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;				
		
		paramMap.put("pageIndex",pageIndex);
		paramMap.put("pageSize",pageSize);
		
		List<QnaModel> qnaListModel = qnaService.qnaList(paramMap);
		model.addAttribute("qnaListModel",qnaListModel);
		
		int totalCount = qnaService.countqnaList(paramMap);
		
		model.addAttribute("totalqnaCount",totalCount);
		
		model.addAttribute("pageSize",pageSize);
		model.addAttribute("currentPageqnaList",currentPage);
		
		logger.info("+end"+className+"qnaList");
		
		return "/scmStandard/QnaList";
	}
	
	@RequestMapping("qnaSelect.do")
	@ResponseBody
	public Map<String, Object> qnaSelect (Model model ,@RequestParam Map<String,Object> paramMap, HttpServletRequest request,
			HttpServletResponse response,HttpSession session) throws Exception{
		
		logger.info("-Start  "+className+"  qnaSelect");
		logger.info("-paramMap   "+paramMap);
		
		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";
		
		QnaModel qnaModel = qnaService.qnaSelect(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("qnaModel", qnaModel);
		
		logger.info("+end  "+className+"  qnaSelect");
		
		return resultMap;
	}
	
	@RequestMapping("qnaAnswer.do")
	
	public String qnaAnswer (Model model ,@RequestParam Map<String,Object> paramMap, HttpServletRequest request,
			HttpServletResponse response,HttpSession session){
		
		logger.info("Start"+className+"qnaAnswer");
		logger.info("-paramMap"+paramMap);
		
		
		
		
		logger.info("+end"+className+"qnaAnswer");
		
		return "/scmStandard/QnaAnswer";
	}
	
	
	
	
	
	
	
	
	
}
