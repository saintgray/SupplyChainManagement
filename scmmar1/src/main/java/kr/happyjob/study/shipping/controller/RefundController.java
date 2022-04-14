package kr.happyjob.study.shipping.controller;

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

import kr.happyjob.study.scm.service.refundInfoService;
import kr.happyjob.study.shipping.model.RefundModel;
import kr.happyjob.study.shipping.service.RefundService;

@Controller
@RequestMapping("/dlm/")
public class RefundController {

	@Autowired
	RefundService refundService; 
	
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	/**
	 * 반품지시서 초기 화면
	 */
	@RequestMapping("refundBuyer.do")
	public String refundBuyer(Model model, @RequestParam Map<String,Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {	
		return "shipping/refund";
	}
	
	
	/**
	 * 반품지시서 목록 조회		callAjax url주소 text타입
	 */
	@RequestMapping("listRefund.do")
	public String listRefund(Model model, @RequestParam Map<String,Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listRefund");
		logger.info("   - paramMap : " + paramMap);		
		
		//	파싱
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
		//	페이지 시작 row
		int pageIndex = (currentPage-1) * pageSize;
		logger.info("   - pageIndex : " + pageIndex);
		
		//	SQL 리미트에 쓸 파라미터들
		paramMap.put("pageIndex", pageIndex);	//리미트 조건: pageIndex부터 시작해서
		paramMap.put("pageSize", pageSize);		//pageSize값 만큼 조회할거다
		
		//	SQL 반품지시서 목록 조회 selectList
		List<RefundModel> listRefund = refundService.listRefund(paramMap);
		model.addAttribute("listRefund", listRefund);
		
		//	SQL 반품지시서 목록 카운트
		int totalCount = refundService.countListRefund(paramMap);
		model.addAttribute("totalCntListRefund", totalCount);
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageListRefund", currentPage);
		
		
		logger.info("+ End " + className + ".listRefund");
		
		return "shipping/refundList";
	}
	
}
