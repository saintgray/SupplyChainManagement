package kr.happyjob.study.scmTask.controller;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.scmTask.model.PaybackOrderModel;
import kr.happyjob.study.scmTask.service.PaybackOrderService;

@Controller
@RequestMapping("/scmTask/")
public class PaybackOrderController {
	
	
	@Autowired
	PaybackOrderService paybackOrderService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	/**
	 * 반품지시서 관리 초기화면
	 */
	@RequestMapping("paybackOrder.do")
	public String initPaybackOrder(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".initPaybackOrder");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".initPaybackOrder");

		return "scmTask/paybackOrder";
	}
	
	
	/**
	 * 반품지시서 조회
	 */
	@RequestMapping("listPaybackOrder.do")
	public String listPaybackOrder(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listPaybackOrder");
		logger.info("   - paramMap : " + paramMap);		
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;									// 페이지 시작 row 번호
				
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);		
		
		// 반품지시서 목록 조회
		List<PaybackOrderModel> listPaybackOrderModel = paybackOrderService.listPaybackOrder(paramMap);
		model.addAttribute("listPaybackOrderModel", listPaybackOrderModel);
		
		// 반품지시서 목록 카운트 조회
		int totalCount = paybackOrderService.countListPaybackOrder(paramMap);
		model.addAttribute("totalCntPaybackOrder", totalCount);
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPagePaybackOrder",currentPage);		
		
		logger.info("+ End " + className + ".listPaybackOrder");
		

		return "/scmTask/paybackOrderList";
	}
	
	
	
	
	@ResponseBody
	@RequestMapping(value = "PaybackOrderYn.do", method = RequestMethod.GET)
	public int updateMgrYn(String mgryn, PaybackOrderModel paybackOrderModel) throws Exception {
		
		System.out.println("=========입금여부 Ajax START============");
		int result = paybackOrderService.updateOdryn(paybackOrderModel);
		if(result !=  0) {
			return result;
		}
		return result;
	}

}
