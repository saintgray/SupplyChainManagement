package kr.happyjob.study.scmDeal.controller;

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

import kr.happyjob.study.scmDeal.model.ReturnApplyModel;
import kr.happyjob.study.scmDeal.service.ReturnApplyService;
import kr.happyjob.study.scmStandard.model.QnaModel;

@Controller
@RequestMapping("/scmDeal/")
public class ReturnApplyController {

	@Autowired
	ReturnApplyService returnApplyService;
	
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	private final String className = this.getClass().toString();
	
	@RequestMapping("ReturnApply.do")
	public String ReturnApply(@RequestParam Map<String, Object> paramMap){
		
		logger.info("+ Start " + className + ". ReturnApply");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ". ReturnApply");
		
		return "/scmDeal/ReturnApply";
	}
	
	@RequestMapping("ReturnList.do")
	public String ReturnList(HttpServletRequest request , HttpSession session , HttpServletResponse response, @RequestParam Map<String,Object> paramMap
			,Model model) throws Exception{
		
		logger.info("+ Start " + className + ". ReturnList");
		logger.info("   - paramMap : " + paramMap);
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;		
		
		paramMap.put("pageIndex",pageIndex);
		paramMap.put("pageSize",pageSize);
		
		List<ReturnApplyModel> ReturnListModel =returnApplyService.ReturnList(paramMap);
		model.addAttribute("ReturnListModel",ReturnListModel);
		
		int totalCount = returnApplyService.CountReturnList(paramMap);
		model.addAttribute("totalCount",totalCount);
		
		model.addAttribute("pageSize",pageSize);
		model.addAttribute("currentPageqnaList",currentPage);
		
		
		logger.info("+ End " + className + ". ReturnList");
		
		
		return "scmDeal/ReturnList";
	}
	
	@RequestMapping("ReturnSelect.do")
	@ResponseBody
	public Map<String, Object> ReturnSelect(HttpServletRequest request , HttpSession session , HttpServletResponse response, @RequestParam Map<String,Object> paramMap
			,Model model) throws Exception{
		
		logger.info("-Start  "+className+"  ReturnSelect");
		logger.info("-paramMap   "+paramMap);
		
		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";
		
		ReturnApplyModel ReturnSelectModel = returnApplyService.ReturnSelect(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("ReturnSelectModel", ReturnSelectModel);
		
		logger.info("+end  "+className+"  ReturnSelect");
		
		return resultMap;
		
	}
	
	@RequestMapping("ReturnApproval.do")
	@ResponseBody
	public Map<String, Object> ReturnApproval(HttpServletRequest request , HttpSession session , HttpServletResponse response, @RequestParam Map<String,Object> paramMap
			,Model model) throws Exception{
		
		logger.info("-Start  "+className+"  ReturnApproval");
		logger.info("-paramMap   "+paramMap);
		
		String result = "SUCCESS";
		String resultMsg = "저장 되었습니다.";
		
		
		//재고창고 인설트
		//returnApplyService.ReturnStock(paramMap);
		//관리장 승인
		returnApplyService.ReturnApproval(paramMap);
		

		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+end  "+className+"  ReturnApproval");
		
		return resultMap;
		
	}
	
	
	
	
}
