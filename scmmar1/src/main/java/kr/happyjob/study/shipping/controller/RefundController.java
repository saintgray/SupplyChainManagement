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

import kr.happyjob.study.shipping.model.RefundModel;
import kr.happyjob.study.shipping.model.ShippingModel;
import kr.happyjob.study.shipping.service.RefundService;

@Controller
@RequestMapping("/dlm/")
public class RefundController {

	@Autowired
	RefundService refundService; 
	
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	/**
	 * 반품지시서 초기 화면
	 */
	@RequestMapping("refundBuyer.do")
	public String refundBuyer(Model model, @RequestParam Map<String,Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {	
		return "shipping/refund";
	}
	
	
	/**
	 * 반품지시서 목록 조회		callAjax url주소 text타입
	 */
	@ResponseBody
	@RequestMapping("listRefund.do")
	public Map<String, Object> listRefund(Model model, @RequestParam Map<String,Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listRefund");
		logger.info("   - paramMap : " + paramMap);		
		
		//	파싱
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
		//	페이지 시작 row
		int pageIndex = (currentPage-1) * pageSize;
		logger.info("   - pageIndex : " + pageIndex);
		
		//	SQL 리미트에 쓸 파라미터들
		paramMap.put("pageIndex", pageIndex);	//리미트 조건: pageIndex부터 시작해서
		paramMap.put("pageSize", pageSize);		//pageSize값 만큼 조회할거다
		
		Map<String,Object> resultMap = new HashMap<String, Object>();
		
		//	SQL 반품지시서 목록 조회 selectList
		List<RefundModel> listRefund = refundService.listRefund(paramMap);
//		model.addAttribute("listRefund", listRefund);
		resultMap.put("listRefund", listRefund);
		
		//	SQL 반품지시서 목록 카운트
		int totalCount = refundService.countListRefund(paramMap);
//		model.addAttribute("totalCntListRefund", totalCount);
		resultMap.put("totalCntListRefund", totalCount);
		
		//model.addAttribute("pageSize", pageSize);
		resultMap.put("pageSize", pageSize);
		//model.addAttribute("currentPageListRefund", currentPage);
		resultMap.put("currentPageListRefund", currentPage);
		
		
		logger.info("+ End " + className + ".listRefund");
		
		return resultMap;
	}
	
	@RequestMapping("detailRefund.do")
	@ResponseBody
	public Map<String, Object> selectDeliOrder (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, 
			HttpServletResponse response, HttpSession session) throws Exception{
		
		logger.info("+ Start " + className + ".detailRefund");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";
		
		// 오브젝트 -> 스트링 -> 인트 변환
		int return_id = Integer.parseInt((String)paramMap.get("return_id"));
		paramMap.put("return_id", return_id);
		
		// 반품지시서 상세 페이지
		RefundModel refundModel = refundService.detailRefund(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("refundModel", refundModel);
		
		logger.info("+ End " + className + ".detailRefund");

		return resultMap;
	}
	
	@RequestMapping("saveDeliReturn.do")
	@ResponseBody
	public Map<String, Object> saveDeliReturn (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, 
			HttpServletResponse response, HttpSession session) throws Exception{
		
		//logger.info("+ Start " + className + ".saveDeliOrder");
		logger.info("   - paramMap : " + paramMap);
		
		String result = "SUCCESS";
		String resultMsg = "성공! 배송완료 처리되었습니다!";
		
		// $("#myForm").serialize() 값 가져오기, json타입
		String action = (String)paramMap.get("action");	//폼 액션
		String deliverStatus = (String)paramMap.get("deliverStatus");	//배송상태
		paramMap.put("status", "E");
		//반품 상태 변경
		
		if(deliverStatus.equals("U")){
//			배송상태 변경
			int ret = refundService.updateDeliReturnDir(paramMap);
			//logger.info("   - ret : " + ret);
			if(ret==1){
				refundService.updateDelidelivDir(paramMap);
				refundService.insertDeparturehis(paramMap);
				refundService.updateStockReduce(paramMap);
				//창고재고 증가 
				//재고입출내역 insert
				
			}

			
		} else {
			result = "FALSE";
			resultMsg = "실패! 알수 없는 요청 입니다.";
		}
				
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".saveDeliOrder");
		return resultMap;
	}
	
	
	
}
