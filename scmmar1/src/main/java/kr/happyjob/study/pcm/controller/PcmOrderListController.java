package kr.happyjob.study.pcm.controller;

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

import kr.happyjob.study.pcm.model.PcmOrderListModel;
import kr.happyjob.study.pcm.service.PcmOrderListService;


@Controller
@RequestMapping("/pcm/")
public class PcmOrderListController {

	@Autowired
	PcmOrderListService pcmOrderListService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	/**
	 * 초기화면
	 */
	     @RequestMapping("purchaseOrder.do")
	public String initpurchaseOrder(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".initpurchaseOrder");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".initpurchaseOrder");

		return "/pcm/purchaseOrderList";
	}
	     
	     /**
	 	 * 발주 내역 목록 출력
	 	 */
	 	@RequestMapping("listPurchaseOrder.do")
		public String listPurchaseOrder(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
	 		
	 		
			logger.info("+ Start " + className + ".pcmOrderList");
			logger.info("   - paramMap : " + paramMap);
			
			int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
			int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
			
			int pageIndex = (currentPage-1)*pageSize;									// 페이지 시작 row 번호
					
			paramMap.put("pageIndex", pageIndex);
			paramMap.put("pageSize", pageSize);
			
			
			// 발주내역목록 조회
			List<PcmOrderListModel> listPurchaseOrderModel = pcmOrderListService.listPurchaseOrder(paramMap);
			model.addAttribute("listPurchaseOrderModel", listPurchaseOrderModel);
			
			// 발주내역 목록 카운트 조회
			int totalCount = pcmOrderListService.totalCount(paramMap);
			model.addAttribute("totalCnt", totalCount);
			
			model.addAttribute("pageSize", pageSize);
			model.addAttribute("currentPage",currentPage);
			
			logger.info("+ End " + className + ".listPurchaseOrder");
			
			//모델에 담긴 데이터들이 전달된다.
			return "pcm/orderList";
		}
	 	
		@RequestMapping("pcmOrderOne.do")
		@ResponseBody
		public Map<String, Object> pcmOrderOne (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".pcmOrderOne");
			logger.info("   - paramMap : " + paramMap);

			String result = "SUCCESS";
			String resultMsg = "조회 되었습니다.";
			
			PcmOrderListModel pcmOrderListModel = pcmOrderListService.pcmOrderOne(paramMap);
			//logger.info("   - pcmOrderListModel : " + pcmOrderListModel.toString());
			
			Map<String, Object> resultMap = new HashMap<String, Object>();
			resultMap.put("result", result);
			resultMap.put("resultMsg", resultMsg);
			resultMap.put("pcmOrderListModel", pcmOrderListModel);
			
			return resultMap;
		
		}
		
	 	
}

