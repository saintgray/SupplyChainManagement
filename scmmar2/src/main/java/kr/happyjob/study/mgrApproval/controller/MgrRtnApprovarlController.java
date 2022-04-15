package kr.happyjob.study.mgrApproval.controller;

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

import kr.happyjob.study.mgrApproval.model.MgrRtnApprovalModel;
import kr.happyjob.study.mgrApproval.service.MgrRtnApprovalService;

@Controller
@RequestMapping("/mgrApproval/")
public class MgrRtnApprovarlController {

	@Autowired
	MgrRtnApprovalService mgrRtnApprovalService;
		
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	/**
	 * 반품승인목록 초기화면
	 */
	@RequestMapping("rtnApproval.do")
	public String rtnApproval(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".rtnApproval");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".rtnApproval");

		return "mgrApproval/rtnApproval";
	}
	
	/**
	 * 반품목록 조회
	 */
	@RequestMapping("rtnApprovalList.do")
	public String rtnApprovalList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		System.out.println("-------------aaaaa---------->"+Integer.parseInt((String)paramMap.get("currentPage")));
	
		logger.info("+ Start " + className + ".rtnApprovalList");
		logger.info("   - paramMap : " + paramMap);
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;												// 페이지 시작 row 번호
		System.out.println("currentPage---------->"+currentPage);
		System.out.println("pageSize---------->"+pageSize);
		System.out.println("pageIndex---------->"+pageIndex);
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		// 반품 목록 조회
		List<MgrRtnApprovalModel> listRtnApprovalModel = mgrRtnApprovalService.listRtnApproval(paramMap);
		model.addAttribute("listRtnApprovalModel", listRtnApprovalModel);
		
		logger.info("+ Start " + className + ".rtnApprovalList");
		logger.info("   - paramMap : " + paramMap);
		
		// 반품 목록 카운트 조회
		int totalCount = mgrRtnApprovalService.countListRtnApproval(paramMap);
		model.addAttribute("totalCntRtnApproval", totalCount);
		System.out.println("totalCount---------->"+totalCount);
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageRtnApproval",currentPage);
		
		logger.info("+ End " + className + ".rtnApprovalList");
		

		return "/mgrApproval/rtnApprovalList";
		
	}
		
		/**
		 * 임원승인여부 수정
		 */
		@RequestMapping("updateRtnMgrYn.do")
		@ResponseBody
		public Map<String, Object> updateRtnMgrYn(Model model, @RequestParam  Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
		
			System.out.println("-----------------updateRtnMgrYn--------------->>");
			logger.info("+ Start " + className + ".updateRtnMgrYn");
			logger.info("   - paramMap : " + paramMap);
			
			String result = "SUCCESS";
			String resultMsg = "승인되었습니다.";
			
			mgrRtnApprovalService.updateRtnMgrYn(paramMap);
					
			Map<String, Object> resultMap = new HashMap<String, Object>();
			resultMap.put("result", result);
			resultMap.put("resultMsg", resultMsg);
			
			logger.info("+ End " + className + ".updateRtnMgrYn");
			
			return resultMap;
		
	}	
}
