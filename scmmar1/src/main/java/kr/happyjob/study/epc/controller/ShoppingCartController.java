package kr.happyjob.study.epc.controller;

import java.util.ArrayList;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.epc.model.ShoppingCartItemDTO;
import kr.happyjob.study.epc.service.ShoppingCartService;

@Controller
@RequestMapping("/epc")
public class ShoppingCartController {

	@Autowired
	ShoppingCartService scservice;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	@RequestMapping(value="/shoppingCart", method=RequestMethod.GET)
	public String sc() {
		
		return "epc/shoppingCart";
	}
	
	
	@RequestMapping(value="/getShoppingCartList", method=RequestMethod.GET)
	@ResponseBody
	public ArrayList<ShoppingCartItemDTO> gscl() {
		ArrayList<ShoppingCartItemDTO> list = scservice.getCartList("apple");
		
		return list;
	}
	
	@RequestMapping(value="/deleteCartItem", method=RequestMethod.POST)
	@ResponseBody
	public int dcl(@RequestParam String sales_id) {
		logger.info(sales_id);
		
		return 1;
	}
}
