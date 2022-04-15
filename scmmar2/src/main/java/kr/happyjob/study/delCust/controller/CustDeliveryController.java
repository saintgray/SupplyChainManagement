package kr.happyjob.study.delCust.controller;

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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.delCust.dao.CustDeliveryDao;
import kr.happyjob.study.delCust.model.CustDeliveryModel;
import kr.happyjob.study.delCust.service.CustDeliveryService;
import kr.happyjob.study.scmTask.model.DeliveryModel;

@Controller
@RequestMapping("/delCust/")
public class CustDeliveryController {

	@Autowired
	CustDeliveryService custDeliveryService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	/**
	 * 초기화면
	 */
	@RequestMapping("deliveryBuyer.do")
	public String CustDeliveryMain(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
	
		return "delCust/custDelivery";
	}
	
	
	/**
	 * 목록 조회
	 */
	@RequestMapping("listCustDelivery.do")
	public String listCustDelivery (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
			
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;												// 페이지 시작 row 번호
				
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		// 목록 조회
		List<CustDeliveryModel> listCustDeliveryModel = custDeliveryService.listCustDelivery(paramMap);
		model.addAttribute("listCustDeliveryModel", listCustDeliveryModel);
		
		// 목록 카운트 조회
		int totalCount = custDeliveryService.countCustDelivery(paramMap);
		
		model.addAttribute("totalCntDelivery", totalCount);
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageDelivery",currentPage);
		
		logger.info("+ End " + className + ".listCustDelivery");
		
		return "/delCust/custDeliveryList";
	}
	
	
	/**
	 *  상세 조회
	 */
	@RequestMapping("selectCustDelivery.do")
	@ResponseBody
	public Map<String, Object> selectDelivery (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectCustDelivery");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";
		
		// 상세 조회
		CustDeliveryModel custDeliveryModel = custDeliveryService.selectCustDelivery(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("custDeliveryModel", custDeliveryModel);			
	
		logger.info("+ End " + className + ".selectCustDelivery");
		
		return resultMap;
	}
	
}
