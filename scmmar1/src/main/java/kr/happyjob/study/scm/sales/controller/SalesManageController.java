package kr.happyjob.study.scm.sales.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.scm.sales.model.PageInfo;
import kr.happyjob.study.scm.sales.model.SalesRegData;
import kr.happyjob.study.scm.sales.service.SalesManageService;

@Controller
@RequestMapping("/scm/")
public class SalesManageController {
	
	private Logger logger=LoggerFactory.getLogger(this.getClass());
	private final String className=this.getClass().toString();
	
	private SalesManageService smService;
	
	
	public SalesManageController() {
		
	}
	
	@Autowired
	public SalesManageController(SalesManageService smService) {
		
		this.smService = smService;
		
	}

	
	
	// 제품 정보 관리 페이지로 이동
	@GetMapping("/productMng.do")
	public String initSalesMngView(){
		
		logger.info("init {}", className);
		
		return "scm/sales/salesmngmain";
	}
	

	// 상품 리스트 받아오기
	@PostMapping(value="/saleslist", produces=MediaType.TEXT_HTML_VALUE)
	public String getSales(Model model, PageInfo info){
		
		try{
			
		
			
			model.addAttribute("page", smService.getSalesList(info));
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		System.out.println(info.getTotalCount());
		
		
		return "scm/sales/system/salesList";
	}
	
	@PostMapping("/sales/form")
	public String initSalesForm(Model model, String action, String sales_id){
		
		
		System.out.println(action);
		
		model.addAttribute("action",action);
		
		if(!action.equalsIgnoreCase("NEW")){
			model.addAttribute("info",smService.getSalesDetails(sales_id));
		}
		
		
		return "scm/sales/system/salesForm";
	}
	
	@PostMapping("/sales/manage")
	@ResponseBody
	public int manageSales(SalesRegData data, String action, HttpServletRequest req){
		
		int result=0;
		
		try{
			
			if(action.equalsIgnoreCase("REGISTER")){
				
				result=smService.insertSales(data, req);

	
			}else if(action.equalsIgnoreCase("UPDATE")){
				
				result=smService.updateSales(data, req);
				
			}else{
				
				result=smService.deleteSales(data.getSales_id());
			}
			
		}catch(Exception e){
			
				
		
		}
		
		return result;
	}
	

}
