package kr.happyjob.study.scm.supplier.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.happyjob.study.scm.supplier.service.SupplyManageService;

@Controller
@RequestMapping("/scm")
public class SupplyManageController {
	
	private SupplyManageService supplyService;
	
	
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
	
	
	
	
	
	

}
