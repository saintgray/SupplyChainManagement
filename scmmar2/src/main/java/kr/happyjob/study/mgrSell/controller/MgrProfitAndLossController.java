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

import kr.happyjob.study.mgrSell.model.MgrProfitAndLossDtModel;
import kr.happyjob.study.mgrSell.model.MgrProfitAndLossModel;
import kr.happyjob.study.mgrSell.model.MgrSellStatusDtModel;
import kr.happyjob.study.mgrSell.model.MgrSellStatusModel;
import kr.happyjob.study.mgrSell.service.MgrProfitAndLossService;
import kr.happyjob.study.mgrSell.service.MgrSellStatusService;

@Controller
@RequestMapping("/mgrSell/")
public class MgrProfitAndLossController {

	@Autowired
	MgrProfitAndLossService mgrProfitAndLossService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	/**
	 * 손익 목록 초기화면
	 */
	@RequestMapping("profitAndLoss.do")
	public String profitAndLoss(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".profitAndLoss");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".profitAndLoss");

		return "mgrSell/profitAndLoss";
	}
	
	/**
	 * 손익 목록 조회
	 */
	@RequestMapping("profitAndLossList.do")
	public String listProfitAndLoss(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		//System.out.println("-------------aaaaa---------->"+Integer.parseInt((String)paramMap.get("currentPage")));
	
		logger.info("+ Start " + className + ".profitAndLossList");
		logger.info("   - paramMap : " + paramMap);
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;												// 페이지 시작 row 번호
		System.out.println("currentPage---------->"+currentPage);
		System.out.println("pageSize---------->"+pageSize);
		System.out.println("pageIndex---------->"+pageIndex);
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		// 손익 목록 조회
		List<MgrProfitAndLossModel> listMgrProfitAndLossModel = mgrProfitAndLossService.listProfitAndLoss(paramMap);
		model.addAttribute("listMgrProfitAndLossModel", listMgrProfitAndLossModel);
		
		logger.info("+ Start " + className + ".profitAndLossList");
		logger.info("   - paramMap : " + paramMap);
		
		// 손익 목록 카운트 조회
		int totalCount = mgrProfitAndLossService.countListProfitAndLoss(paramMap);
		model.addAttribute("totalCntProfitAndLoss", totalCount);
		System.out.println("totalCount---------->"+totalCount);
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageProfitAndLoss",currentPage);
		
		logger.info("+ End " + className + ".profitAndLossList");
		

		return "/mgrSell/profitAndLossList";
	}
		
		
		/**
		 * 손익 상세 목록 조회
		 */
		@RequestMapping("profitAndLossDtList.do")
		public String listDtProfitAndLoss(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".profitAndLossDtList");
			logger.info("   - paramMap : " + paramMap);
			
			
			int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
			int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
			int pageIndex = (currentPage-1)*pageSize;												// 페이지 시작 row 번호
			System.out.println("매출 현황currentPage---------->"+currentPage);
			System.out.println("매출 현황pageSize---------->"+pageSize);
			System.out.println("매출 현황pageIndex---------->"+pageIndex);

			paramMap.put("pageIndex", pageIndex);
			paramMap.put("pageSize", pageSize);
			
			// 손익 상세 목록 조회
			List<MgrProfitAndLossDtModel> listMgrProfitAndLossDtModel = mgrProfitAndLossService.listDtProfitAndLoss(paramMap);
			model.addAttribute("listMgrProfitAndLossDtModel", listMgrProfitAndLossDtModel);
			System.out.println("------------listMgrProfitAndLossDtModel----------end");
			// 손익 상세 목록 카운트 조회
			int DtTotalCount = mgrProfitAndLossService.countListDtProfitAndLoss(paramMap);
			model.addAttribute("totalCntDtProfitAndLoss", DtTotalCount);
			System.out.println("매출 현황 상세totalCount---------->"+DtTotalCount);
			
			model.addAttribute("pageSize", pageSize);
			model.addAttribute("currentPageDtSellSatus",currentPage);
			
			logger.info("+ End " + className + ".profitAndLossDtList");

			return "/mgrSell/profitAndLossDtList";
		}	
		
}
