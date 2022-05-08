package kr.happyjob.study.epc.controller;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.epc.model.SearchParamDTO;
import kr.happyjob.study.epc.model.ShoppingCartItemDTO;
import kr.happyjob.study.epc.service.ShoppingCartService;

@Controller
@RequestMapping("/epc")
public class ShoppingCartVueController {

	@Autowired
	ShoppingCartService scservice;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	@RequestMapping(value="/ShoppingCart-vue.do", method=RequestMethod.GET)
	public String sc() {
		
		return "epc/shoppingCart-vue";
	}
	
	
	@RequestMapping(value="/getShoppingCartList-vue", method=RequestMethod.GET)
	@ResponseBody
	public Map<String,Object> gscl(HttpSession session, SearchParamDTO param) {
		
		//load params
		String loginID = (String)session.getAttribute("loginId");
		param.setLoginID(loginID);
		param.setStartIndex((param.getCurrentPage()-1) * param.getPageBlockSize());
		int totalCount = scservice.getCartListTotalCount(loginID);
		List<ShoppingCartItemDTO> list = scservice.getCartList(param);
		Map<String,Object> result = new HashMap<>();
		
		//set params
		result.put("cartList", list);
		result.put("totalCountCartList", totalCount);
		return result;
	}
	
	@RequestMapping(value="/deleteCartItem-vue", method=RequestMethod.POST)
	@ResponseBody
	public int dclv(HttpSession session,
			@RequestParam String sales_id, 
			@RequestParam String wantedDate,
			HttpServletRequest request) {
		
		//list all headers
		Enumeration<String> headerNames = request.getHeaderNames();
		while(headerNames.hasMoreElements()) {
		  String headerName = headerNames.nextElement();
		  System.out.println("Header Name - " + headerName + ", Value - " + request.getHeader(headerName));
		}
		
		//list all params
		Enumeration<String> params = request.getParameterNames(); 
		while(params.hasMoreElements()){
		 String paramName = params.nextElement();
		 System.out.println("Parameter Name - "+paramName+", Value - "+request.getParameter(paramName));
		}
		
		
		
		
		//load params
		String loginId = (String)session.getAttribute("loginId");
		Map<String,String> paramMap = new HashMap<>();
		
		
		//set params
		paramMap.put("loginID", loginId);
		paramMap.put("wanteddate", wantedDate);
		paramMap.put("sales_id", sales_id);
		
		int result = 0;
		try {
			result = scservice.deleteCartItem(paramMap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	
	@RequestMapping(value="/payCart-vue", method=RequestMethod.POST)
	@ResponseBody
	public int pcv(HttpSession session, 
			@RequestBody Map<String, Object> param,
			HttpServletRequest request) {
		
		//list all headers
		Enumeration<String> headerNames = request.getHeaderNames();
		while(headerNames.hasMoreElements()) {
		  String headerName = headerNames.nextElement();
		  System.out.println("Header Name - " + headerName + ", Value - " + request.getHeader(headerName));
		}
		
		//list all params
		Enumeration<String> params = request.getParameterNames(); 
		while(params.hasMoreElements()){
		 String paramName = params.nextElement();
		 System.out.println("Parameter Name - "+paramName+", Value - "+request.getParameter(paramName));
		}
		
		
		
		
		String loginId = (String)session.getAttribute("loginId");
		String userType= session.getAttribute("userType").toString();
		int result=0;
		
		logger.info("payCart-vue > param");
		logger.info(param);
		logger.info((String)param.get("json"));
		
		try{
			result=scservice.orderProductsVue((String)param.get("json"), loginId,userType);
		}catch(Exception e){
			e.printStackTrace();
		}
//		
		return result;
	}
	
}

