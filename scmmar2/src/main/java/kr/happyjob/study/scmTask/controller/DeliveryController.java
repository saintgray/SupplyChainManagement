package kr.happyjob.study.scmTask.controller;

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

import kr.happyjob.study.scmTask.model.DeliveryModel;
import kr.happyjob.study.scmTask.service.DeliveryService;


@Controller
@RequestMapping("/scmTask/")
public class DeliveryController {
	
	@Autowired
	DeliveryService deliveryService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	/**
	 * 초기화면
	 */
	@RequestMapping("shippingDirection.do")
	public String DeliveryMain(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		return "scmTask/delivery";
	}
	
	/**
	 * 목록 조회
	 */
	@RequestMapping("listDelivery.do")
	public String listDelivery (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
			
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;												// 페이지 시작 row 번호
				
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		// 목록 조회
		List<DeliveryModel> listDeliveryModel = deliveryService.listDelivery(paramMap);
		model.addAttribute("listDeliveryModel", listDeliveryModel);
		
		// 목록 카운트 조회
		Integer totalCount = deliveryService.countListDelivery(paramMap);
//		logger.info("+ totalCount ; " + totalCount);
		
		model.addAttribute("totalCntDelivery", totalCount);
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageDelivery",currentPage);
		
		logger.info("+ End " + className + ".listDelivery");
		

		return "/scmTask/deliveryList";
	}	
	
	/**
	 *  상세 조회
	 */
	@RequestMapping("selectDelivery.do")
	@ResponseBody
	public Map<String, Object> selectDelivery (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectDelivery");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";
		
		// 상세 조회
		DeliveryModel deliveryModel = deliveryService.selectDelivery(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("deliveryModel", deliveryModel);			
	
		logger.info("+ End " + className + ".selectDelivery");
		
		return resultMap;
	}
}
