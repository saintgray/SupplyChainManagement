package kr.happyjob.study.mgrSell.controller;

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

import kr.happyjob.study.mgrSell.model.MgrSellStatusDtModel;
import kr.happyjob.study.mgrSell.model.MgrSellStatusModel;
import kr.happyjob.study.mgrSell.service.MgrSellStatusService;

@Controller
@RequestMapping("/mgrSell/")
public class MgrSellStatusController {

	@Autowired
	MgrSellStatusService mgrSellStatusService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	/**
	 * 매출 현황 목록 초기화면
	 */
	@RequestMapping("sellStatus.do")
	public String sellStatus(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".sellStatus");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".sellStatus");

		return "mgrSell/sellStatus";
	}
	
	/**
	 * 매출 현황 목록 조회
	 */
	@RequestMapping("sellStatusList.do")
	public String listSellStauts(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		//System.out.println("-------------aaaaa---------->"+Integer.parseInt((String)paramMap.get("currentPage")));
	
		logger.info("+ Start " + className + ".listSellStauts");
		logger.info("   - paramMap : " + paramMap);
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;												// 페이지 시작 row 번호
		System.out.println("currentPage---------->"+currentPage);
		System.out.println("pageSize---------->"+pageSize);
		System.out.println("pageIndex---------->"+pageIndex);
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		// 매출 현황 목록 조회
		List<MgrSellStatusModel> listSellStautsModel = mgrSellStatusService.listSellStauts(paramMap);
		model.addAttribute("listSellStautsModel", listSellStautsModel);
		
		logger.info("+ Start " + className + ".listSellStauts");
		logger.info("   - paramMap : " + paramMap);
		
		// 매출 현황 목록 카운트 조회
		int totalCount = mgrSellStatusService.countListSellStauts(paramMap);
		model.addAttribute("totalCntSellStatus", totalCount);
		System.out.println("totalCount---------->"+totalCount);
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageSellStatus",currentPage);
		
		logger.info("+ End " + className + ".sellStatusList");
		

		return "/mgrSell/sellStatusList";
	}
		
		
		/**
		 * 매출 현황 상세 목록 조회
		 */
		@RequestMapping("sellStatusDtList.do")
		public String listDtSellStauts(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".listDtSellStauts");
			logger.info("   - paramMap : " + paramMap);
			
			
			int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
			int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
			int pageIndex = (currentPage-1)*pageSize;												// 페이지 시작 row 번호
			System.out.println("매출 현황currentPage---------->"+currentPage);
			System.out.println("매출 현황pageSize---------->"+pageSize);
			System.out.println("매출 현황pageIndex---------->"+pageIndex);

			paramMap.put("pageIndex", pageIndex);
			paramMap.put("pageSize", pageSize);
			
			// 매출 현황 상세 목록 조회
			List<MgrSellStatusDtModel> listDtSellStautsModel = mgrSellStatusService.listDtSellStauts(paramMap);
			model.addAttribute("listDtSellStautsModel", listDtSellStautsModel);
			System.out.println("------------listDtSellStautsModel----------end");
			// 매출 현황 상세 목록 카운트 조회
			int DtTotalCount = mgrSellStatusService.countListDtSellStauts(paramMap);
			model.addAttribute("totalCntDtSellStauts", DtTotalCount);
			System.out.println("매출 현황 상세totalCount---------->"+DtTotalCount);
			
			model.addAttribute("pageSize", pageSize);
			model.addAttribute("currentPageDtSellSatus",currentPage);
			
			logger.info("+ End " + className + ".listDtSellStauts");

			return "/mgrSell/sellStatusDtList";
		}	
		
}
