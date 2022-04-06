package kr.happyjob.study.scm.warehouse.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.apache.log4j.chainsaw.Main;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.scm.user.service.UserInfoService;
import kr.happyjob.study.scm.warehouse.model.PageInfo;
import kr.happyjob.study.scm.warehouse.model.WarehouseDetail;
import kr.happyjob.study.scm.warehouse.service.WarehouseService;
import kr.happyjob.study.system.model.ComnCodUtilModel;
import kr.happyjob.study.system.model.PhoneNumberModel;

@Controller
@RequestMapping("/scm")
public class WarehouseController {
	
	private WarehouseService whService;
	private UserInfoService uiService;
	
	
	public WarehouseController() {
		
	}
	

	

	@Autowired
	public WarehouseController(WarehouseService whService, UserInfoService uiService) {
	
		this.whService = whService;
		this.uiService = uiService;
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
	public int whManage(WarehouseDetail regdata, String action, PhoneNumberModel tel, String email_prefix, String email_suffix){
		
		System.out.println(email_prefix);
		System.out.println(email_suffix);
		
		regdata.setPhone(tel.getPhoneNumber());
		
		System.out.println(regdata.getPhone());
		
		
		
		return 1;
	}
	
	/**
	 * 담당자 selectBox 동적 생성을 담당하는 Method
	 * @author OJH
	 * 
	 */
	@RequestMapping("/whComcombo.do")
	@PostMapping
	@ResponseBody
	public Map<String,Object> initComcombo(String group_code){
		
		List<ComnCodUtilModel> list=uiService.getAdvisorCod(group_code);
		
		Map<String, Object> resultMap= new HashMap<String, Object>();
		
		resultMap.put("list", list);
		
		
		return resultMap;
	}
	
	/**
	 *  창고 위치 동적 생성을 담당하는 Method
	 *  @author OJH
	 */
	@RequestMapping("/LocCombo.do")
	@PostMapping
	@ResponseBody
	public Map<String,Object> initLocCombo(String group_code){
		Map<String, Object> resultMap=null;
		
		try{
			List<ComnCodUtilModel> list=whService.getLocCod(group_code);
			resultMap= new HashMap<String, Object>();
			resultMap.put("list", list);
		}catch(Exception e){
			
		}
		
		return resultMap;
		
	}

}
