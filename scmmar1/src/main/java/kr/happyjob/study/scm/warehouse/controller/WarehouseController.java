package kr.happyjob.study.scm.warehouse.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.scm.warehouse.model.PageInfo;
import kr.happyjob.study.scm.warehouse.service.WarehouseService;

@Controller
@RequestMapping("/scm")
public class WarehouseController {
	
	private WarehouseService whService;
	
	
	public WarehouseController() {
		
	}
	

	@Autowired
	public WarehouseController(WarehouseService whService) {
		
		this.whService = whService;
	}





	@RequestMapping("/whinfo.do")
	@GetMapping
	public String initWhInfoMain(){
		
		return "scm/warehouse/warehousemngmain";
	}
	
	
	@RequestMapping("/whlist")
	@PostMapping
	public String getWhList(Model model, String action, PageInfo param){
		
		model.addAttribute("page", whService.getWareHouseList(param));
		model.addAttribute("action",action);
		return "scm/warehouse/system/whList";
	}
	
	@RequestMapping("/whinfo")
	@PostMapping
	public String getWhInfo(Model model, String action, String wh_id){
		
		if(!action.equalsIgnoreCase("NEW")){
			model.addAttribute("info", whService.getWareHouseInfo(wh_id));
		}
		model.addAttribute("action", action);
		
		return "scm/warehouse/system/whForm";
	}
	
	
	@RequestMapping("/whManage")
	@PostMapping
	@ResponseBody
	public int whManage(){
		
		return 0;
	}
	

}
