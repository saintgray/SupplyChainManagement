package kr.happyjob.study.scm.supplier.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.happyjob.study.scm.supplier.model.PageInfo;
import kr.happyjob.study.scm.supplier.service.SupplyManageService;

@RestController
@RequestMapping("/scm/vue")
public class VueSupplyManageController {
	
	
	private SupplyManageService supplyService;
	private final Logger logger= LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	public VueSupplyManageController(SupplyManageService supplyService) {
		this.supplyService = supplyService;
	}
	
	
	@GetMapping("/suppliers")
	public Map<String,Object> getSuppliers(PageInfo info,HttpServletResponse resp){
		
		Map<String, Object> page = new HashMap<String, Object>();
		
		try{
			
			page.put("page", supplyService.getSuppliers(info));
			
		}catch(Exception e){
			
		}
		return page;
	}
	
	
	
	
	
	
	

}
