package kr.happyjob.study.scm.warehouse.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.happyjob.study.scm.user.service.UserInfoService;
import kr.happyjob.study.scm.warehouse.exception.StockRemainsException;
import kr.happyjob.study.scm.warehouse.model.PageInfo;
import kr.happyjob.study.scm.warehouse.model.WarehouseDetail;
import kr.happyjob.study.scm.warehouse.service.WarehouseService;
import kr.happyjob.study.system.model.ComnCodUtilModel;

@RestController("/scm/vue")
public class VueWarehouseController {

	// private final Logger logger = LogManager.getLogger(this.getClass());
	
	
	private WarehouseService whService;
	private UserInfoService uiService;
	
	public VueWarehouseController() {
		
	}
	

	

	@Autowired
	public VueWarehouseController(WarehouseService whService, UserInfoService uiService) {
		this.whService = whService;
		this.uiService=uiService;
	}





	@RequestMapping("/whinfo.do")
	@GetMapping
	public String initWhInfoMain(){
		
		return "scm/warehouse/warehousemngmain";
	}
	
	
	@RequestMapping("/whlist")
	@PostMapping
	public Map<String,Object> getWhList(Model model, String action, PageInfo param){
		
		Map<String, Object> result=new HashMap<>();
		try{
			result.put("page", whService.getWareHouseList(param));
			
		}catch(Exception e){
			result.put("errMsg", "오류가 발생하였습니다. 잠시 후 다시 시도하세요");
		}

		return result;
	}
	
	@PostMapping("/whinfo")
	public Map<String,Object> getWhInfo(Model model, String action, String wh_id, HttpSession session){
		
		Map<String,Object> result=new HashMap<>();
		
		
		
		if(!action.equalsIgnoreCase("NEW")){
			WarehouseDetail info=null;
			info = whService.getWareHouseInfo(wh_id, session);
			result.put("info",info);
		}else{
			result.put("locationList", whService.getLocCod("wareCD"));
		}
		result.put("advisorList", uiService.getAdvisorCod("B"));
		
		
		return result;	}
	
	



}
