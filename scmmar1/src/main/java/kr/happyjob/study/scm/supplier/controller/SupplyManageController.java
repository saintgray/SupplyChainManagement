package kr.happyjob.study.scm.supplier.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.happyjob.study.scm.supplier.model.PageInfo;
import kr.happyjob.study.scm.supplier.service.SupplyManageService;

@Controller
@RequestMapping("/scm")
public class SupplyManageController {
	
	private SupplyManageService supplyService;
	private final Logger logger= LoggerFactory.getLogger(this.getClass());
	
	
	public SupplyManageController() {

	}

	@Autowired
	public SupplyManageController(SupplyManageService supplyService) {
		
		this.supplyService = supplyService;
	}

	
	@GetMapping("/supplierInfo.do")
	public String initSupplyManageMain(){
		
		return "scm/supply/supplymngmain";
	}
	
	@PostMapping("/supplier/list")
	public String getList(Model model, PageInfo info){
		
		try{
			
			model.addAttribute("page",supplyService.getSuppliers(info));
			
			
		}catch(Exception e){
			logger.info("CATCHED EXCEPTION : {} \n {}",e.getMessage(), e.getStackTrace());
		}
		
		
		return "scm/supply/system/supplyList";
	}
	
	@PostMapping("/supplier/info")
	public String getSupplierImpSales(Model model, String comp_id){
		
		try{
			
			model.addAttribute("impSales", supplyService.getImpSales(comp_id));
		}catch(Exception e){
			logger.info("CATCHED EXCEPTION {} \n {} ",e.getMessage(), e.getStackTrace());
		}
		
		
		return "scm/supply/system/importSalesList";
	}
	
	
	
	
	
	
	

}
