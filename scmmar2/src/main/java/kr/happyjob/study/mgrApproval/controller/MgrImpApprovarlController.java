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

import kr.happyjob.study.mgrApproval.model.MgrImpApprovalModel;
import kr.happyjob.study.mgrApproval.service.MgrImpApprovalService;
import kr.happyjob.study.system.model.ComnDtlCodModel;

@Controller
@RequestMapping("/mgrApproval/")
public class MgrImpApprovarlController {

	@Autowired
	MgrImpApprovalService mgrImpApprovalService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	/**
	 * 발주승인목록 초기화면
	 */
	@RequestMapping("impApproval.do")
	public String impApproval(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".impApproval");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".impApproval");

		return "mgrApproval/impApproval";
	}
	
	/**
	 * 발주목록 조회
	 */
	@RequestMapping("listImpApproval.do")
	public String listImpApproval(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		//System.out.println("-------------aaaaa---------->"+Integer.parseInt((String)paramMap.get("currentPage")));
	
		logger.info("+ Start " + className + ".listImpApproval");
		logger.info("   - paramMap : " + paramMap);
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;												// 페이지 시작 row 번호
		System.out.println("currentPage---------->"+currentPage);
		System.out.println("pageSize---------->"+pageSize);
		System.out.println("pageIndex---------->"+pageIndex);
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		// 발주 목록 조회
		List<MgrImpApprovalModel> listImpApprovalModel = mgrImpApprovalService.listImpApproval(paramMap);
		model.addAttribute("listImpApprovalModel", listImpApprovalModel);
		
		logger.info("+ Start " + className + ".listImpApproval");
		logger.info("   - paramMap : " + paramMap);
		
		// 발주 목록 카운트 조회
		int totalCount = mgrImpApprovalService.countListImpApproval(paramMap);
		model.addAttribute("totalCntImpApproval", totalCount);
		System.out.println("totalCount---------->"+totalCount);
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageImpApproval",currentPage);
		
		logger.info("+ End " + className + ".listImpApproval");
		

		return "/mgrApproval/impApprovalList";
	}
		
		/**
		 * 임원승인여부 수정
		 */
		@RequestMapping("updateImpMgrYn.do")
		@ResponseBody
		public Map<String, Object> updateImpMgrYn(Model model, @RequestParam  Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			System.out.println("-----------------updateImpMgrYn--------------->>");
			logger.info("+ Start " + className + ".updateImpMgrYn");
			logger.info("   - paramMap : " + paramMap);
			
			String result = "SUCCESS";
			String resultMsg = "승인되었습니다.";
			
			mgrImpApprovalService.updateImpMgrYn(paramMap);
					
			Map<String, Object> resultMap = new HashMap<String, Object>();
			resultMap.put("result", result);
			resultMap.put("resultMsg", resultMsg);
			
			logger.info("+ End " + className + ".updateImpMgrYn");
			
			return resultMap;
		}
		
		/**
		 * 발주 상세 목록 조회
		 */
		@RequestMapping("listDtImpApproval.do")
		public String listDtImpApproval(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".listDtImpApproval");
			logger.info("   - paramMap : " + paramMap);
			
			
			int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
			int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
			int pageIndex = (currentPage-1)*pageSize;												// 페이지 시작 row 번호
			System.out.println("발주상세currentPage---------->"+currentPage);
			System.out.println("발주상세pageSize---------->"+pageSize);
			System.out.println("발주상세pageIndex---------->"+pageIndex);

			paramMap.put("pageIndex", pageIndex);
			paramMap.put("pageSize", pageSize);
			
			// 발주 상세 목록 조회
			List<MgrImpApprovalModel> listDtImpApprovalModel = mgrImpApprovalService.listDtImpApproval(paramMap);
			model.addAttribute("listDtImpApprovalModel", listDtImpApprovalModel);
			System.out.println("------------listDtImpApprovalModel----------end");
			// 발주 상세 목록 카운트 조회
			int DtTotalCount = mgrImpApprovalService.countListImpApprovalDt(paramMap);
			model.addAttribute("totalCntDtImpApproval", DtTotalCount);
			System.out.println("발주상세totalCount---------->"+DtTotalCount);
			
			model.addAttribute("pageSize", pageSize);
			model.addAttribute("currentPageImpApprvalDt",currentPage);
			
			logger.info("+ End " + className + ".listDtImpApproval");

			return "/mgrApproval/impApprovalDtList";
		}	
		
		
		
		
}
