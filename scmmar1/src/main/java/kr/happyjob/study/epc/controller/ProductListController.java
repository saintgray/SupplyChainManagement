package kr.happyjob.study.epc.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

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
import kr.happyjob.study.epc.model.SearchParamDTO;
import kr.happyjob.study.epc.model.ShoppingCartItemDTO;
import kr.happyjob.study.epc.service.ProductListService;

@Controller
@RequestMapping("/epc")
public class ProductListController {

	@Autowired
	ProductListService pservice;

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	@RequestMapping(value="/productList.do", method=RequestMethod.GET)
	public String pl(Model model) {
		
		/*int totalCount = comnCodService.countListComnGrpCod(paramMap);*/
		model.addAttribute("totalProductListCnt", 18);
		model.addAttribute("currentPageProductList", 1);
		return "epc/productList";
	}
	
	@RequestMapping(value="/getProductList", method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> gpl(
			Model model,
				SearchParamDTO param
			) {
		
		HashMap<String, Object> result = new HashMap<>();
		param.setStartIndex((param.getCurrentPage()-1)*param.getPageBlockSize());
		param.setPageBlockSize(param.getPageBlockSize());
		ArrayList<SalesModel> list = pservice.getListProduct(param);
		int totalCntProductList = pservice.getListProductCnt(param);
		result.put("list", list);
		result.put("totalCntProductList", totalCntProductList);
		return result;
	}
	
	@RequestMapping(value="/getProductDetail", method=RequestMethod.POST)
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
	
	@RequestMapping(value="/orderProduct", method=RequestMethod.POST)
	@ResponseBody
	public Integer op( ShoppingCartItemDTO param,
			HttpSession session) {
		
		logger.info("op param");
		logger.info(param);
		
		param.setLoginID((String)session.getAttribute("loginId"));
		Integer result = pservice.orderAndCartProduct(param);

		return result;
	}
	 
}

