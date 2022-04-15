package kr.happyjob.study.scmTask.controller;

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

import kr.happyjob.study.scmStandard.model.QnaModel;
import kr.happyjob.study.scmTask.model.ImpOrderModel;
import kr.happyjob.study.scmTask.service.ImpOrderService;
import kr.happyjob.study.system.model.ComnGrpCodModel;

@Controller
@RequestMapping("/scmTask/")
public class ImpOrderController {

	@Autowired
	ImpOrderService impOrderService;
	
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	private final String className = this.getClass().toString();
	
	@RequestMapping("ImpOrder.do")
	public String ImpOrder(){
		
		return "/scmTask/ImpOrder";
	}
	
		
	@RequestMapping("ImpSearch.do")
	public String ImpSearch(HttpServletRequest request , HttpSession session , HttpServletResponse response , @RequestParam Map<String , Object> paramMap,
			Model model) throws Exception{
		
		logger.info("-Start"+className+"ImpSearch");
		logger.info("- paramMap"+paramMap);
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;												// 페이지 시작 row 번호
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		List<ImpOrderModel> impSearchModel = impOrderService.ImpSerach(paramMap);  
		model.addAttribute("impList",impSearchModel);

		// 발주지시서 목록 카운트 조회
		   
		int totalCount = impOrderService.countImp(paramMap);
		
		model.addAttribute("totalCount",totalCount);
		
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageComnGrpCod",currentPage);
		
		logger.info("+ End " + className + ".ImpSearch");
		
		
		return "scmTask/ImpList";
	}
	
	
}
