package kr.happyjob.study.ged.controller;

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

import kr.happyjob.study.ged.model.OrderConfirmModel;
import kr.happyjob.study.ged.service.OrderConfirmService;

@Controller
@RequestMapping("/ged/")
public class OderConfirmController {
	
	@Autowired
	OrderConfirmService oderConfirmService;
	
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
		
		return "ged/OrderConfirm";
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
			List<OrderConfirmModel> orderConfirmList = oderConfirmService.orderConfirmList(paramMap);
			model.addAttribute("orderConfirm", orderConfirmList);
			
			System.out.println(orderConfirmList);
			
			// 목록 수 추출해서 보내기
			int orderConfirmCnt = oderConfirmService.orderConfirmCnt(paramMap);
			
			model.addAttribute("orderConfirmList", orderConfirmList);
		    model.addAttribute("orderConfirmCnt", orderConfirmCnt);
		    model.addAttribute("pageSize", pageSize);
		    model.addAttribute("currentPage",currentPage);
		    
		    return "ged/OrderConfirmList";
		}
		
		@RequestMapping("OrderOne.do")
		@ResponseBody
		public Map<String, Object> orderconfirmsubmit(
				Model model, @RequestParam Map<String, Object> paramMap, 
				HttpServletRequest request, HttpServletResponse response, 
				HttpSession session
				)throws Exception {
			
			logger.info("+ Start " + className + ".orderconfirmsubmit");
			logger.info("   - paramMap : " + paramMap);
			
			String confirmYN = (String) paramMap.get("confirmYN");
			int orderid = Integer.parseInt((String) paramMap.get("orderid"));
			
			String result = "SUCCESS";
			String resultMsg = "";			  
			
			paramMap.put("orderid", orderid);
			paramMap.put("confirmYN", confirmYN);
			
			try{
				
				oderConfirmService.updateorderConfirm(paramMap);
			}catch(Exception e){
				
			} 
			
            if("Y".equals(confirmYN)) {
            	resultMsg = "승인 되었습니다";
            } else {
            	resultMsg = "반려 되었습니다";
            }
  
			
			Map<String, Object> resultMap = new HashMap<String, Object>();
			resultMap.put("result", result);
			resultMap.put("resultMsg", resultMsg);		
			
			
			logger.info("+ End " + className + ".orderconfirmsubmit");
		
		return resultMap;
		}

}
