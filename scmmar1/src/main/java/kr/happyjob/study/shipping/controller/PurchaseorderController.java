package kr.happyjob.study.shipping.controller;

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

import kr.happyjob.study.shipping.model.PurchaseorderModel;
import kr.happyjob.study.shipping.model.RefundModel;
import kr.happyjob.study.shipping.model.ShippingModel;
import kr.happyjob.study.shipping.service.PurchaseorderService;
import kr.happyjob.study.shipping.service.RefundService;
import kr.happyjob.study.shipping.service.ShippingService;

@Controller
@RequestMapping("/dlm/")
public class PurchaseorderController {

	@Autowired
	PurchaseorderService purchaseService;
	
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	/**
	 * 발주 반품 지시서 초기 화면
	 */
	@RequestMapping("purchaseorder.do")
	public String orderRefund(Model model, @RequestParam Map<String,Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {	
		return "shipping/purchaseorder";
	}
	
	@RequestMapping("listPurchaseorder.do")
	@ResponseBody
	public Map<String,Object> listDeliOrder(Model model, @RequestParam Map<String,Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
	
		//ogger.info("+ Start " + className + ".ListPurchaseOrder");
		logger.info("   - paramMap : " + paramMap);		
		
		
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));	// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;	// 페이지 시작 row 번호
		//logger.info("   - pageIndex : " + pageIndex);
		
		//SQL 리미트에 쓸 파라미터들
		paramMap.put("pageIndex", pageIndex);	//리미트 조건: pageIndex부터 시작해서
		paramMap.put("pageSize", pageSize);		//pageSize값 만큼 조회할거다
		
		// 발주/반품 목록 조회
		List<PurchaseorderModel> ListPurchaseOrder = purchaseService.ListPurchaseOrder(paramMap);
		Map<String,Object> resultMap = new HashMap<String, Object>();
//		model.addAttribute("ListPurchaseOrder", ListPurchaseOrder);
		resultMap.put("ListPurchaseOrder", ListPurchaseOrder);
		
		// 발주/반품 목록 개수 조회
		int totalcount = purchaseService.countListPurchaseOrder(paramMap);
		//model.addAttribute("totalCntListDeliOrder", totalcount);	
		resultMap.put("totalCntListDeliOrder", totalcount);
		//model.addAttribute("pageSize", pageSize);	//10
		resultMap.put("pageSize",pageSize);
		//model.addAttribute("currentPageListDeliOrder",currentPage);	//1
		resultMap.put("currentPageListDeliOrder", currentPage);
		
		//logger.info("+ End " + className + ".ListPurchaseOrder");

		
		return resultMap;
	}
	
	/**
	 *  배송지시서 단건 상세 조회 	파라미터: deliv_id
	 */
	@RequestMapping("selectPurchaseOrder.do")
	@ResponseBody
	public Map<String, Object> selectDeliOrder (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, 
			HttpServletResponse response, HttpSession session) throws Exception{
		
		logger.info("+ Start " + className + ".selectPurchaseOrder");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";
		
		
		// 배송지시서 단건 상세 조회
		PurchaseorderModel purchaseorderModel = purchaseService.selectPurchaseOrder(paramMap);
		System.out.println("purchaseorderModel  == " + purchaseorderModel);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("purchaseorderModel", purchaseorderModel);
		
		logger.info("+ End " + className + ".selectPurchaseOrder");

		return resultMap;
	}
	
	
}
