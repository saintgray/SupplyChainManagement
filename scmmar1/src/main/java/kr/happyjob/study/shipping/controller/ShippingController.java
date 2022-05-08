package kr.happyjob.study.shipping.controller;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.shipping.model.ShippingModel;
import kr.happyjob.study.shipping.service.ShippingService;

@Controller
@RequestMapping("/dlm/")
public class ShippingController {
	
	@Autowired
	ShippingService shippingService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	/**
	 * 배송지시서 초기 화면
	 */
	@RequestMapping("deliveryBuyer.do")
	public String deliveryBuyer(Model model, @RequestParam Map<String,Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {		
		return "shipping/order";
	}
	
	
	/**
	 * 배송지시서 목록 조회		callAjax url주소
	 */
	@ResponseBody
	@RequestMapping("listDeliOrder.do")
	public Map<String,Object> listDeliOrder(Model model, @RequestParam Map<String,Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		// MultipartFile fileTest
		//logger.info("+ Start " + className + ".listDeliOrder");
		logger.info("   - paramMap : " + paramMap);
		/*
		if(!paramMap.containsKey("fileTest")) { //파일이 있을시 실행 에러방지 조건
			if(!fileTest.isEmpty()) {
				System.out.println(" fileTEst ==" + fileTest);//  파일 업로드 테스트
			}
		}
		*/ 
		
		int currentPage = Integer.parseInt((paramMap.get("currentPage").toString()));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)(paramMap.get("pageSize").toString()));	// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;	// 페이지 시작 row 번호
		//logger.info("   - pageIndex : " + pageIndex);
		//SQL 리미트에 쓸 파라미터들
		paramMap.put("pageIndex", pageIndex);	//리미트 조건: pageIndex부터 시작해서
		paramMap.put("pageSize", pageSize);		//pageSize값 만큼 조회할거다
		
		
		// 배송지시서 목록 조회
		List<ShippingModel> listShippingModel = shippingService.listDeliOrder(paramMap);
		
		Map<String,Object> resultMap = new HashMap<String, Object>();
//		model.addAttribute("listShippingModel", listShippingModel);
		resultMap.put("listShippingModel", listShippingModel);
		
		
		// 배송지시서 목록 개수 조회
		int totalcount = shippingService.countListDeliOrder(paramMap);
//		model.addAttribute("totalCntListDeliOrder", totalcount);	
		resultMap.put("totalCntListDeliOrder", totalcount);	
		
//		model.addAttribute("pageSize", pageSize);	//10
		resultMap.put("pageSize", pageSize);	//10
//		model.addAttribute("currentPageListDeliOrder",currentPage);	//1
		resultMap.put("currentPageListDeliOrder",currentPage);	//1
		
		logger.info("+ End " + className + ".listDeliOrder");

		
		return resultMap;
	}
	
	
	/**
	 *  배송지시서 단건 상세 조회 	파라미터: deliv_id
	 */
	@RequestMapping("selectDeliOrder.do")
	@ResponseBody
	public Map<String, Object> selectDeliOrder (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, 
			HttpServletResponse response, HttpSession session) throws Exception{
		System.out.println("selectDeliOrder  Page");
		logger.info("+ Start " + className + ".selectDeliOrder");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";
		
		// 오브젝트 -> 스트링 -> 인트 변환
		int deliv_id = Integer.parseInt((String)paramMap.get("deliv_id"));
		paramMap.put("deliv_id", deliv_id);
		
		// 배송지시서 단건 상세 조회
		ShippingModel shippingModel = shippingService.selectDeliOrder(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("shippingModel", shippingModel);
		
		logger.info("+ End " + className + ".selectDeliOrder");

		return resultMap;
	}
	
	
	/**
	 *  배송지시서 배송상태 변경 		파라미터: deliv_id, action, deliverStatus, pur_cnt
	 */
	@RequestMapping("saveDeliOrder.do")
	@ResponseBody
	public Map<String, Object> saveDeliOrder (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, 
			HttpServletResponse response, HttpSession session) throws Exception{
		
		logger.info("+ Start " + className + ".saveDeliOrder");
		logger.info("   - paramMap : " + paramMap);
		String result = "SUCCESS";
		String resultMsg = "성공! 배송완료 처리되었습니다!";
		
		// $("#myForm").serialize() 값 가져오기, json타입
		String action = (String)paramMap.get("action");	//폼 액션
		String deliverStatus = (String)paramMap.get("deliverStatus");	//배송상태
		System.out.println(" action ============ " + action  + "//////////// deliverStatus =======" + deliverStatus);
		if("U".equals(action)&& (deliverStatus.equals("U") || deliverStatus.equals("O"))){
			//배송상태 변경
			int deliv_id = Integer.parseInt((String)paramMap.get("deliv_id"));	//배송 번호
			paramMap.put("deliv_id", deliv_id);
			int ret = shippingService.updateDeliOrder(paramMap);
			logger.info("   - ret : " + ret);
			if(ret==1 && deliverStatus.equals("U")){
				
				ShippingModel shippingModel = shippingService.selectDeliOrder(paramMap);
				int pur_cnt = shippingModel.getPur_cnt();
				paramMap.put("pur_cnt", pur_cnt);
				int deliv_wh_id = shippingModel.getDeliv_wh_id();
				paramMap.put("wh_id", deliv_wh_id);
				int sales_id = shippingModel.getSales_id();
				paramMap.put("sales_id", sales_id);
				//창고재고 감소  
				shippingService.updateStockReduce(paramMap);
				//재고입출내역 insert
				shippingService.insertDeparturehis(paramMap);
			}

			
		} else {
			result = "FALSE";
			resultMsg = "실패! 알수 없는 요청 입니다.";
		}
		System.out.println("-----------------------5");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".saveDeliOrder");
		return resultMap;
	}
	
	
	
	
	
	
	
}
