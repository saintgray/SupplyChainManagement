package kr.happyjob.study.scm.sales.controller;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.happyjob.study.scm.sales.model.PageInfo;
import kr.happyjob.study.scm.sales.model.SalesDetails;
import kr.happyjob.study.scm.sales.service.SalesManageService;

@RestController("/scm/vue")
public class VueSalesManageController {

	
	
	private Logger logger=LoggerFactory.getLogger(this.getClass());
	private final String className=this.getClass().toString();
	
	private SalesManageService smService;
	
	
	public VueSalesManageController() {
	}
	
	@Autowired
	public VueSalesManageController(SalesManageService smService) {
		this.smService = smService;
	}




	// 상품 리스트 받아오기
	@PostMapping(value="/saleslist", produces=MediaType.TEXT_HTML_VALUE)
	public Map<String, Object> getSales(Model model, PageInfo info){
		
		Map<String, Object> result= new HashMap<String, Object>();
		
		
		try{
			
			result.put("page", smService.getSalesList(info));
//			model.addAttribute("page", smService.getSalesList(info));
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return result;
	}
	
	@PostMapping("/sales/{formType}/{salesID}")
	public Map<String, Object> initSalesForm(Model model, @PathVariable String formType, @PathVariable String salesID){
		
		Map<String, Object> result=new HashMap<>();
		
		
		// model.addAttribute("action",action);
		
		if(!formType.equalsIgnoreCase("NEW")){
			// model.addAttribute("info",smService.getSalesDetails(sales_id));
			result.put("info",smService.getSalesDetails(salesID));
		}else{
			result.put("info",new SalesDetails());
		}
		
		
		return result;
	}	
}
