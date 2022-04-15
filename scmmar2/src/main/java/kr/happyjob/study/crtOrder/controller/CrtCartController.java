package kr.happyjob.study.crtOrder.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.json.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import kr.happyjob.study.crtOrder.model.CrtCartModel;
import kr.happyjob.study.crtOrder.model.CrtOrderModel;
import kr.happyjob.study.crtOrder.service.CrtCartService;
import net.sf.json.JSONArray;

@Controller
@RequestMapping("/crt/")
public class CrtCartController {
	
	@Autowired
	CrtCartService crtCartService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	//장바구니목록 초기화면	
	@RequestMapping("ShoppingCart.do")
	public String cartInit(Model model,HttpSession session){
		return "crtOrder/cart";
	}
	
	//장바구니목록 뿌려주기
	@RequestMapping("ShoppingCartList.do")
	public String selectCartList(Model model,HttpSession session){
		
		Map<String, Object> paramMap = new HashMap<String,Object>();
		paramMap.put("loginID", (String)session.getAttribute("loginId"));
		
		List<CrtCartModel> cartList = crtCartService.cartInfoList(paramMap);
		
		model.addAttribute("cartList",cartList);
		
		logger.debug("{} 장바구니 리스트 : "+cartList);
		
		return "crtOrder/cartList";
	}
	
	
	
	
	
	
	//장바구니에서 수주정보 입력
	@RequestMapping("saveCartOrder.do")
	@ResponseBody
	public String saveCartOrder(@RequestParam Map<String,Object> paramMap ,HttpSession session){
			
		//사용자 정보 등록
		paramMap.put("userID", (String)session.getAttribute("loginId"));
		
		int result = crtCartService.saveCartOrder(paramMap);
		
		String resultMsg = "";
		
		if(result>0){
			resultMsg = "SUCCESS";
			
		}else{
			resultMsg = "FAIL";
		}
		
		return resultMsg;
	}
	
	
	//장바구니에서 수주정보 상세 입력
		/*@RequestMapping("saveCartOrderDetail.do")
		@ResponseBody
		public Map<String,Object> saveCartOrderDetail(@RequestParam Map<String,Object> paramMap ,HttpSession session){
			
			System.out.println("paramMap상세"+paramMap);
			
			int result = crtCartService.saveCartOrderDetail(paramMap);
			String successMsg ="";
			String resultMsg = "";
			Map<String,Object> resultMap = new HashMap<String,Object>();
			
			
			if(result>0){
				successMsg = "SUCCESS";
				resultMsg = "주문이 완료되었습니다.";
				resultMap.put("successMsg", successMsg);
				resultMap.put("resultMsg", resultMsg);
				
			}else{
				resultMsg = "FAIL";
				resultMap.put("resultMsg", resultMsg);
			}
			
			return resultMap;
		}*/
	@RequestMapping(value = "saveCartOrderDetail.do")
	@ResponseBody
	public Map<String,Object> saveCartOrderDetail(@RequestParam Map<String,Object> paramData ,HttpSession session) throws Exception{
		
		logger.info("+ Start " + className + ".saveCartOrderDetail");
		logger.info("   - paramMap : " + paramData);
		
	    String jsonStr = paramData.get("param").toString();
		
	    List<Map<String,Object>> cartlist = new ArrayList<Map<String,Object>>();
	    
		cartlist = JSONArray.fromObject(jsonStr);
		
		int result = 0;
		
		for(Map<String,Object> resultMap : cartlist ){
			result = crtCartService.saveCartOrderDetail(resultMap);
			crtCartService.deleteCart(Integer.parseInt((String)resultMap.get("cartno")));
		}
		
		String successMsg ="";
		String resultMsg = "";
		Map<String,Object> resultMap = new HashMap<String,Object>();
		
		
		if(result>0){
			successMsg = "SUCCESS";
			resultMsg = "주문이 완료되었습니다.";
			resultMap.put("successMsg", successMsg);
			resultMap.put("resultMsg", resultMsg);
			
		}else{
			resultMsg = "FAIL";
			resultMap.put("resultMsg", resultMsg);
		}
		
		logger.info("+ End " + className + ".saveCartOrderDetail");
		
		return resultMap;
	}
	
	@RequestMapping("deleteCart.do")
	@ResponseBody
	public Map<String,Object> deleteCart(@RequestParam int cartno ,HttpSession session) throws Exception{

		logger.info("+ Start " + className + ".deleteCart");
		logger.info("   - paramMap : " + cartno);
		
		int result  = crtCartService.deleteCart(cartno);
		
		Map<String,Object> resultMap = new HashMap<String,Object>();
		
		String successMsg ="";
		String resultMsg = "";
		
		if(result>0){
			successMsg = "SUCCESS";
			resultMsg = "삭제가 완료되었습니다.";
			resultMap.put("successMsg", successMsg);
			resultMap.put("resultMsg", resultMsg);
			
		}else{
			resultMsg = "FAIL";
			resultMap.put("resultMsg", resultMsg);
		}
		
		logger.info("   - resultMap : " + resultMap);
		
		
		
		logger.info("+ End " + className + ".deleteCart");
		
		return resultMap;
		
	}
}
