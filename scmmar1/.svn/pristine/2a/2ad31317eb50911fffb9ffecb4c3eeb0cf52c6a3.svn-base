package kr.happyjob.study.epc.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.epc.model.SalesModel;
import kr.happyjob.study.epc.service.ProductListService;

@Controller
@RequestMapping("/epc")
public class ProductListController {

	@Autowired
	ProductListService pservice;

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	@RequestMapping(value="/productList", method=RequestMethod.GET)
	public String pl(Model model) {
		
		
		return "epc/productList";
	}
	
	@RequestMapping(value="/getProductList", method=RequestMethod.GET)
	@ResponseBody
	public ArrayList<SalesModel> gpl() {
		ArrayList<SalesModel> list = pservice.getListProduct();
		
		return list;
	}
	
	@RequestMapping(value="/getProductDetail", method=RequestMethod.GET)
	@ResponseBody
	public SalesModel gpd( @RequestParam int sales_id ) {
		SalesModel product = pservice.getProductDetail(sales_id);
		
		return product;
	}
	
	@RequestMapping(value="/getSalesTypeList", method=RequestMethod.GET)
	@ResponseBody
	public ArrayList<String> gstl() {
		ArrayList<String> stList = pservice.getSalesTypeList();
		
		return stList;
	}
	
	@RequestMapping(value="/getMfcompList", method=RequestMethod.POST)
	@ResponseBody
	public ArrayList<String> gmfcl( @RequestParam String salesType) {
		ArrayList<String> mfclist = pservice.getMfcompListBySalesType(salesType);
		
		return mfclist;
	}
	
	@RequestMapping(value="/searchProductList", method=RequestMethod.POST)
	@ResponseBody
	public ArrayList<SalesModel> spl( @RequestParam String salesType, @RequestParam String mfcomp) {
		HashMap<String, String> params = new HashMap<>();
		params.put("salesType", salesType);
		params.put("mfcomp", mfcomp);
		ArrayList<SalesModel> slist = pservice.searchProductList(params);
		
		return slist;
	}
	
	@RequestMapping(value="/orderProduct", method=RequestMethod.POST)
	@ResponseBody
	public String spl( @RequestParam String saled_id,
			@RequestParam String order_cnt, @RequestParam String wanted_date) {
		/*HashMap<String, String> params = new HashMap<>();
		params.put("salesType", salesType);
		params.put("mfcomp", mfcomp);
		ArrayList<SalesModel> slist = pservice.searchProductList(params);*/
		logger.info(saled_id);
		logger.info(order_cnt);
		logger.info(wanted_date);
		
		return "hi to you";
	}
	 
}
