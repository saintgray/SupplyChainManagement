package kr.happyjob.study.scm.supplier.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.happyjob.study.scm.supplier.model.ImpSales;
import kr.happyjob.study.scm.supplier.model.PageInfo;
import kr.happyjob.study.scm.supplier.service.SupplyManageService;

@RestController
@RequestMapping("/scm/vue")
public class VueSupplyManageController {
	

	
	private SupplyManageService supplyService;
	private final Logger logger=LogManager.getLogger(this.getClass());
	
	
	public VueSupplyManageController() {

	}


	@Autowired
	public VueSupplyManageController(SupplyManageService supplyService) {
		this.supplyService = supplyService;
	}
	
	

	@PostMapping("/suppliers")
	public Map<String,Object> getSuppliers(@RequestBody PageInfo info,HttpServletResponse resp){
		
		Map<String, Object> page = new HashMap<String, Object>();
		
		try{
			
			page.put("page", supplyService.getSuppliers(info));
			
		}catch(Exception e){
			
		}
		return page;
	}
	
	

	
	@PostMapping("/supplier/{id}")
	public Map<String,Object> getSupplierImpSales(Model model, @PathVariable(value="id") String idx){
		
		Map<String,Object> result = new HashMap<>();
		
		try{
			List<ImpSales> importList=null;
			importList=supplyService.getImpSales(idx);
			result.put("impSales", importList);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	@PostMapping("/supply/comnCod.do")
	@ResponseBody
	public Map<String, Object> getSupplyComnCod(){
		Map<String, Object> result=new HashMap<String, Object>();
		result.put("list", supplyService.getComnCod());
		
		return result;
	}
	

	
	
	
	
	

}
