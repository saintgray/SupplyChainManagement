package kr.happyjob.study.epc.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.epc.model.SearchParamDTO;
import kr.happyjob.study.epc.model.ShoppingCartItemDTO;
import kr.happyjob.study.epc.service.ShoppingCartService;

@Controller
@RequestMapping("/epc")
public class ShoppingCartController {

	@Autowired
	ShoppingCartService scservice;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	@RequestMapping(value="/ShoppingCart.do", method=RequestMethod.GET)
	public String sc() {
		
		return "epc/shoppingCart";
	}
	
	
	@RequestMapping(value="/getShoppingCartList", method=RequestMethod.GET)
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
	
	@RequestMapping(value="/deleteCartItem", method=RequestMethod.POST)
	@ResponseBody
	public int dcl(HttpSession session,
			@RequestParam String sales_id, 
			@RequestParam String wantedDate) {
		
		//load params
		String loginId = (String)session.getAttribute("loginId");
		Map<String,String> params = new HashMap<>();
		
		
		//set params
		params.put("loginID", loginId);
		params.put("wanteddate", wantedDate);
		params.put("sales_id", sales_id);
		
		int result = 0;
		try {
			result = scservice.deleteCartItem(params);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	
	@RequestMapping(value="/payCart", method=RequestMethod.POST)
	@ResponseBody
	public int pc(HttpSession session, 
			@RequestParam String param) {
		
		String loginId = (String)session.getAttribute("loginId");
		String userType= session.getAttribute("userType").toString();
		int result=0;
		
		
		try{
			result=scservice.orderProducts(param, loginId,userType);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		
		return result;
	}
	
}

