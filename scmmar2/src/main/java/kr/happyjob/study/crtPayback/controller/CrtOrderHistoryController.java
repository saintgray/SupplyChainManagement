package kr.happyjob.study.crtPayback.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.servlet.ModelAndView;

import kr.happyjob.study.crtOrder.model.CrtOrderModel;
import kr.happyjob.study.crtOrder.service.CrtOrderService;
import kr.happyjob.study.crtPayback.model.CrtOrderHistoryModel;
import kr.happyjob.study.crtPayback.model.OrderDetailModel;
import kr.happyjob.study.crtPayback.model.OrderModel;
import kr.happyjob.study.crtPayback.service.CrtOrderHistoryService;
import net.sf.json.JSONArray;

@Controller
@RequestMapping("/crt/")
public class CrtOrderHistoryController {

		@Autowired
		CrtOrderHistoryService crtOrderHistoryService;
	
		// Set logger
		private final Logger logger = LogManager.getLogger(this.getClass());

		// Get class name for logger
		private final String className = this.getClass().toString();

		//주문현황 초기화면	
		@RequestMapping("refundrequest.do")
		public String cartInit(Model model,HttpSession session){
			return "crtPayback/crtOrderHistory";
		}	
		
		//주문현황 리스트 조회
		@RequestMapping("listOrderHistory.do")
		public ModelAndView listOrderHistory(ModelAndView mv, @RequestParam Map<String,Object> paramMap, HttpSession session){
			
			int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
			int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
			int pageIndex = (currentPage-1)*pageSize;			
			
			paramMap.put("pageIndex", pageIndex);
			paramMap.put("pageSize", pageSize);
			paramMap.put("userID", (String)session.getAttribute("loginId"));
			

			logger.info("   - paramMap : " + paramMap);
			
			
			//리스트 조회
			List<OrderModel> listOrderHistoryModel = crtOrderHistoryService.listOrderHistory(paramMap);
			mv.addObject("listOrderHistoryModel",listOrderHistoryModel);
			
			//제품 리스트 카운트 조회
			int totalCount = crtOrderHistoryService.countlistOrderHistory(paramMap);
			
			mv.addObject("totalOrderHistoryCount", totalCount);
			
			mv.addObject("pageSize", pageSize);
			mv.addObject("currentPageProductList",currentPage);
			
			mv.setViewName("crtPayback/crtOrderHistoryList");
			
			return mv;
		}
		
		
		//주문현황 리스트 상세 조회
		@RequestMapping("orderHistoryDtl.do")
		public ModelAndView listorderHistoryDtl(ModelAndView mv, @RequestParam Map<String,Object> paramMap, HttpSession session){
			
			int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
			int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
			int pageIndex = (currentPage-1)*pageSize;			
			
			paramMap.put("pageIndex", pageIndex);
			paramMap.put("pageSize", pageSize);
			paramMap.put("userID", (String)session.getAttribute("loginId"));
			

			logger.info("   - paramMap : " + paramMap);
			
			
			//리스트 조회
			List<OrderDetailModel> listOrderHistoryDtlModel = crtOrderHistoryService.listorderHistoryDtl(paramMap);
			mv.addObject("listorderHistoryDtl",listOrderHistoryDtlModel);
			
			//제품 리스트 카운트 조회
			int totalCount = crtOrderHistoryService.countlistOrderHistoryDtl(paramMap);
			
			
			logger.info("   - listOrderHistoryDtlModel : " + listOrderHistoryDtlModel);
			
			mv.addObject("totalOrderHistoryCountDtl", totalCount);
			
			mv.addObject("pageSize", pageSize);
			mv.addObject("currentPageProductList",currentPage);
			
			mv.setViewName("crtPayback/crtOrderHistoryListDtl");
			
			return mv;
		}
		
		@RequestMapping("listBankList.do")
		@ResponseBody
		public List<Map<String,Object>> listBankList(HttpServletResponse response){
			List<Map<String,Object>> resultMap = crtOrderHistoryService.listBankList();
			response.setContentType("application/json; charset=utf-8");
			return resultMap;
		}
		
		@RequestMapping("saveReturn.do")
		@ResponseBody
		public Map<String,Object> saveReturn(@RequestParam Map<String,Object> paramMap, HttpSession session){
			
			logger.info("+ Start " + className + ".saveReturn");
			logger.info("   - saveReturnparamMap : " + paramMap);
			
		    String jsonStr = paramMap.get("param").toString();
			
		    List<Map<String,Object>> returnlist = new ArrayList<Map<String,Object>>();
		    
		    returnlist = JSONArray.fromObject(jsonStr);
			
		    logger.info("   - saveReturnparamMap : " + returnlist.toString());
		    
			int result = 0;
			
			int rtncnt =  Integer.parseInt(paramMap.get("rtncnt").toString());
			int rtnamount = Integer.parseInt(paramMap.get("rtnamount").toString());
			String rtnio =  (String)paramMap.get("orderno");
			
			for(Map<String,Object> resultMap : returnlist ){
				//1. 수주상세 테이블에서 반품 신청여부 y로 바꾸기
				result = crtOrderHistoryService.updateReturnYn(resultMap);
			}
			
			Map<String,Object> returnMap = new HashMap<String,Object>();
			
			int	result2 = 0;
			
			if(result>0){
				//2. 반품 정보 테이블에 값 넣기
				returnMap.put("rtncnt", rtncnt);		
				returnMap.put("rtnamount", rtnamount);	
				returnMap.put("rtnio",rtnio);
				result2 = crtOrderHistoryService.insertReturnInfo(returnMap);
			
				if(result2>0){
					for(Map<String,Object> resultMap : returnlist ){
						//3. 고객반품상세정보 테이블에 값 넣기 
						resultMap.put("crtrtio", Integer.parseInt((String)resultMap.get("oddtno")));
						resultMap.put("crtncnt", Integer.parseInt((String)resultMap.get("oddtrecnt")));
						resultMap.put("pdcode", Integer.parseInt((String)resultMap.get("pdcode")));
						resultMap.put("crtnprice", Integer.parseInt((String)resultMap.get("oddtrecnt"))*Integer.parseInt((String)resultMap.get("pdmdprice")));
						result = crtOrderHistoryService.insertClientReturn(resultMap);
					}
				}
			}
			
			
			
			
			String successMsg ="";
			String resultMsg = "";
			Map<String,Object> resultMap = new HashMap<String,Object>();
			
			
			if(result>0){
				successMsg = "SUCCESS";
				resultMsg = "반품이 완료되었습니다.";
				resultMap.put("successMsg", successMsg);
				resultMap.put("resultMsg", resultMsg);
				
			}else{
				resultMsg = "FAIL";
				resultMap.put("resultMsg", resultMsg);
			}
			
			logger.info("+ End " + className + ".saveReturn");
			
			return resultMap;
		}
}
