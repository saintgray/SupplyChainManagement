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
import org.springframework.ui.Model;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.happyjob.study.epc.model.SalesModel;
import kr.happyjob.study.epc.model.SearchParamDTO;
import kr.happyjob.study.epc.model.ShoppingCartItemDTO;
import kr.happyjob.study.epc.service.ProductListService;

@Controller
@RequestMapping("/epc")
public class ProductListVueController {

	@Autowired
	ProductListService pservice;

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	//copy controller for vue
	@RequestMapping(value="/productList-vue.do", method=RequestMethod.GET)
	public String plv(Model model) {
		
		int totalCount = pservice.getListProductCnt(new SearchParamDTO());
		model.addAttribute("totalProductListCnt", totalCount);
		model.addAttribute("currentPageProductList", 1);
		return "epc/productList-vue";
	}
	
	
	
	//copy controller for vue
	@RequestMapping(value="/getProductList-vue", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> gplv(
			Model model,
				@RequestBody SearchParamDTO param
				
			) {
		logger.info("gplv > param");
		logger.info(param);
		//SET param
		param.setStartIndex((param.getCurrentPage()-1)*param.getPageBlockSize());
		param.setPageBlockSize(param.getPageBlockSize());
		
		//get data list
		Map<String, Object> result = new HashMap<>();
		List<SalesModel> list = pservice.getListProduct(param);
		result.put("list", list);
		
		//get total count
		int totalCntProductList = pservice.getListProductCnt(param);
		result.put("totalCntProductList", totalCntProductList);
		return result;
	}
	
	//copy controller for vue
	@RequestMapping(value="/getProductDetail-vue", method=RequestMethod.POST)
	@ResponseBody
	public SalesModel gpdv( @RequestParam int sales_id ) {
		SalesModel product = pservice.getProductDetail(sales_id);
		
		return product;
	}
	
	@RequestMapping(value="/getSalesTypeList-vue", method=RequestMethod.GET)
	@ResponseBody
	public List<String> gstlv() {
		List<String> stList = pservice.getSalesTypeList();
		
		return stList;
	}
	
	@RequestMapping(value="/getMfcompList-vue", method=RequestMethod.POST)
	@ResponseBody
	public List<String> gmfclv( @RequestBody Map<String, String> param) {
		List<String> mfclist = pservice.getMfcompListBySalesType(param.get("salesType"));
		
		return mfclist;
	}
	
	@RequestMapping(value="/orderProduct-vue", method=RequestMethod.POST)
	@ResponseBody
	public int opv(  ShoppingCartItemDTO param,
			HttpSession session,
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
		
		
		//set param
		param.setLoginID((String)session.getAttribute("loginId"));

		
		//log param
		logger.info("op param");
		logger.info(param);
		
		//do service
		int result = 0;
		try {
			result = pservice.orderAndCartProduct(param);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return result;
	}
	
	@RequestMapping(value="/orderProduct-vue2", method=RequestMethod.POST)
	@ResponseBody
	public int op2(  @RequestParam MultiValueMap<String, String> requestParams) {
		System.out.println("Multi Value Map : " + requestParams);
		int result = 1;
		return result;
	}
	 
}

