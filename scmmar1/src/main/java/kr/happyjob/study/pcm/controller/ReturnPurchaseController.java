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
import kr.happyjob.study.pcm.model.PcmReturnListModel;
import kr.happyjob.study.pcm.service.PcmReturnListService;


@Controller
@RequestMapping("/pcm/")
public class ReturnPurchaseController {

	@Autowired
	PcmReturnListService pcmReturnListService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	/**
	 * 초기화면
	 */
	     @RequestMapping("returnPurchase.do")
	public String initpurchaseReturn(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".initpurchaseReturn");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".initpurchaseReturn");
	
		return "/pcm/purchasReturnList";
	}
	     
	     /**
	 	 * 반품 내역 목록 출력
	 	 */
	 	@RequestMapping("listPurchaseReturn.do")
		public String listPurchaseReturn(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".pcmOrderList");
			logger.info("   - paramMap : " + paramMap);
			
			int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
			int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
			
			int pageIndex = (currentPage-1)*pageSize;									// 페이지 시작 row 번호
					
			paramMap.put("pageIndex", pageIndex);
			paramMap.put("pageSize", pageSize);
			
			
			// 발주내역목록 조회
			List<PcmReturnListModel> listPurchaseReturnModel = pcmReturnListService.listPurchaseReturn(paramMap);
			model.addAttribute("listPurchaseReturnModel", listPurchaseReturnModel);
			
			// 발주내역 목록 카운트 조회
			int totalCount = pcmReturnListService.totalCount(paramMap);
			model.addAttribute("totalCnt", totalCount);
			
			model.addAttribute("pageSize", pageSize);
			model.addAttribute("currentPage",currentPage);
			
			logger.info("+ End " + className + ".listPurchaseReturn");
			
			//모델에 담긴 데이터들이 전달된다.
			return "pcm/returnList";
		}
	 	
		@RequestMapping("pcmReturnOne.do")
		@ResponseBody
		public Map<String, Object> pcmReturnOne (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".pcmReturnOne");
			logger.info("   - paramMap : " + paramMap);

			String result = "SUCCESS";
			String resultMsg = "조회 되었습니다.";
			
			PcmReturnListModel pcmReturnListModel = pcmReturnListService.pcmReturnOne(paramMap);
			//logger.info("   - pcmOrderListModel : " + pcmOrderListModel.toString());
			
			Map<String, Object> resultMap = new HashMap<String, Object>();
			resultMap.put("result", result);
			resultMap.put("resultMsg", resultMsg);
			resultMap.put("pcmReturnListModel", pcmReturnListModel);
			
			return resultMap;
		
		}
		
	 	
}

