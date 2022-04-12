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

import kr.happyjob.study.ged.model.RefundConfirmModel;
import kr.happyjob.study.ged.service.RefundConfirmService;

@Controller
@RequestMapping("/ged/")
public class RefundConfirmController {
	
	@Autowired
	RefundConfirmService refundConfirmService;
	
    // Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	// 처음 로딩될 때   승인 연결
	@RequestMapping("refundConfirm.do")
	public String init(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".initrefundConfirm");
		logger.info("   - paramMap : " + paramMap);
		
		String loginID = (String) session.getAttribute("loginId");
		paramMap.put("loginID", loginID);
		System.out.println(loginID);
//		paramMap.put("writer", loginID);
		
		return "ged/RefundConfirm";
	}

	// 반품 승인 리스트 출력
		@RequestMapping("refundConfirmList.do")
		public String refundConfirmList(Model model, @RequestParam Map<String, Object> paramMap, 
				HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".refundConfirmList");
			logger.info("   - paramMap : " + paramMap);
			String sales_nm = (String) paramMap.get("sales_nm");
			
			int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재페이지
		    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		    int pageIndex = (currentPage - 1) * pageSize;
			
			paramMap.put("pageIndex", pageIndex);
			paramMap.put("pageSize", pageSize);
			paramMap.put("title", sales_nm);
			
			// 반품 목록 조회
			List<RefundConfirmModel> refundConfirmList = refundConfirmService.refundConfirmList(paramMap);
			model.addAttribute("refundConfirmList", refundConfirmList);
			
			// 목록 수 추출해서 보내기
			int refundConfirmCnt = refundConfirmService.refundConfirmCnt(paramMap);
			
			model.addAttribute("refundConfirmList", refundConfirmList);
		    model.addAttribute("refundConfirmCnt", refundConfirmCnt);
		    model.addAttribute("pageSize", pageSize);
		    model.addAttribute("currentPage",currentPage);
		    
		    return "ged/RefundConfirmList";
		}
		
		@RequestMapping("RefundOne.do")
		@ResponseBody
		public Map<String, Object>refundconfirmsubmit(
				Model model, @RequestParam Map<String, Object> paramMap, 
				HttpServletRequest request, HttpServletResponse response, 
				HttpSession session
				)throws Exception {
			
			logger.info("+ Start " + className + ".returnconfirmsubmit");
			logger.info("   - paramMap : " + paramMap);
			
			String confirmYN = (String) paramMap.get("confirmYN");
			int returnId = Integer.parseInt((String) paramMap.get("returnId"));
			
			String result = "SUCCESS";
			String resultMsg = "";			  
			
			paramMap.put("returnId", returnId);
			paramMap.put("confirmYN", confirmYN);
			
			try{
				
				refundConfirmService.updaterefundConfirm(paramMap);
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
			
			
			logger.info("+ End " + className + ".refundconfirmsubmit");
		
		return resultMap;
		}

}



