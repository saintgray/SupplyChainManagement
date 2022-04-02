package kr.happyjob.study.ged.controller;

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

import kr.happyjob.study.ged.model.orderConfirmModel;
import kr.happyjob.study.ged.service.orderConfirmService;

@Controller
@RequestMapping("/ged/")
public class oderConfirmController {
	
	@Autowired
	orderConfirmService oderConfirmService;
	
    // Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	// 처음 로딩될 때   승인 연결
	@RequestMapping("orderConfirm.do")
	public String init(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".initorderConfirm");
		logger.info("   - paramMap : " + paramMap);
		
		String loginID = (String) session.getAttribute("loginId");
		paramMap.put("loginID", loginID);
		System.out.println(loginID);
//		paramMap.put("writer", loginID);
		
		return "ged/orderConfirm";
	}

	// 발주 승인 리스트 출력
		@RequestMapping("orderConfirmList.do")
		public String orderConfirmList(Model model, @RequestParam Map<String, Object> paramMap, 
				HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".orderConfirmList");
			logger.info("   - paramMap : " + paramMap);
			String sales_nm = (String) paramMap.get("sales_nm");
			
			int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재페이지
		    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		    int pageIndex = (currentPage - 1) * pageSize;
			
			paramMap.put("pageIndex", pageIndex);
			paramMap.put("pageSize", pageSize);
			paramMap.put("title", sales_nm);
			
			// 발주 목록 조회
			List<orderConfirmModel> orderConfirmList = oderConfirmService.orderConfirmList(paramMap);
			model.addAttribute("orderConfirm", orderConfirmList);
			
			// 목록 수 추출해서 보내기
			int orderConfirmCnt = oderConfirmService.orderConfirmCnt(paramMap);
			
			model.addAttribute("orderConfirmList", orderConfirmList);
		    model.addAttribute("orderConfirmCnt", orderConfirmCnt);
		    model.addAttribute("pageSize", pageSize);
		    model.addAttribute("currentPage",currentPage);
		    
		    return "ged/orderConfirmList";
		}
		@RequestMapping("OrderOne.do")
		public String orderconfirmsubmit(
				Model model, @RequestParam Map<String, Object> paramMap, 
				HttpServletRequest request, HttpServletResponse response, 
				HttpSession session
				)throws Exception {
		
		return "ged/OrderOne";
		}

}
