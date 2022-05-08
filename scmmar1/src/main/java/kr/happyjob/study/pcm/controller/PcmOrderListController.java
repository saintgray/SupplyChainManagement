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
	     
	 	
	 	// 0426
	 	  @RequestMapping("listPurchaseOrder.do")
		   @ResponseBody
		   public Map<String,Object> initpurchaseOrderlist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
		         HttpServletResponse response, HttpSession session) throws Exception {
		      
		      logger.info("+ Start " + className + ".initpurchaseOrder");
		      logger.info("   - paramMap : " + paramMap);
		      
		      
		      int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));   // 현재 페이지 번호
		      int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));         // 페이지 사이즈
		      int pageIndex = (currentPage-1)*pageSize;                                    // 페이지 시작 row 번호
		       
		      paramMap.put("pageIndex", pageIndex);
		      paramMap.put("pageSize", pageSize);
		      
		      Map<String, Object> resultMap = new HashMap<String, Object>();
		      
		      // 공통 그룹코드 목록 조회
		      List<PcmOrderListModel> listPurchaseOrderModel = pcmOrderListService.listPurchaseOrder(paramMap);

		      resultMap.put("listPurchaseOrderModel", listPurchaseOrderModel); 
		      
		      int totalCount = pcmOrderListService.totalCount(paramMap);
		      resultMap.put("totalCnt", totalCount); 
		      
		      resultMap.put("pageSize", pageSize);
		      resultMap.put("currentPage",currentPage);
		      

		      return resultMap;
		   }	
	 	
	 	
//======================================================하나 선택	 	
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