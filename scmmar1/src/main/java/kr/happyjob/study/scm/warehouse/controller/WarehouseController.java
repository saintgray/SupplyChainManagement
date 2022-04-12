package kr.happyjob.study.scm.warehouse.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.happyjob.study.scm.user.service.UserInfoService;
import kr.happyjob.study.scm.warehouse.exception.StockRemainsException;
import kr.happyjob.study.scm.warehouse.model.PageInfo;
import kr.happyjob.study.scm.warehouse.model.WarehouseDetail;
import kr.happyjob.study.scm.warehouse.service.WarehouseService;
import kr.happyjob.study.system.model.ComnCodUtilModel;

@Controller
@RequestMapping("/scm")
public class WarehouseController {
	
	
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	
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
	public String getWhInfo(Model model, String action, String wh_id, HttpSession session, RedirectAttributes rdAttr){
		
		
		
		if(!action.equalsIgnoreCase("NEW")){
			WarehouseDetail info=null;
			info = whService.getWareHouseInfo(wh_id, session);
			rdAttr.addFlashAttribute("whID",info.getWh_id());
			model.addAttribute("info", info);
		}
		model.addAttribute("action", action);
		
		return "scm/warehouse/system/whForm";
	}
	
	
	@RequestMapping("/whManage2")
	@PostMapping
	@ResponseBody
	public int whManage(WarehouseDetail data, String action, HttpSession session){
		
		int result=0;
		logger.info(action);
		
		try{
			switch(action){
			case "UPDATE":
				result=whService.updateWarehouse(data);
				break;
			case "REGISTER":
				result=whService.insertWarehouse(data);
				break;
			case "DELETE":
				result=whService.deleteWarehouse(data.getWh_id());
				break;
			}
		}catch(Exception e){
			
			logger.info("catched Exception... is exception instance of StockRemainException?  ".concat(String.valueOf(e instanceof StockRemainsException)));
			if(e instanceof StockRemainsException){
				// 삭제하려는 창고에 재고가 남아있을때 삭제 불가
				result=-1;
			}
			
		}
		return result;
	}
	
	@RequestMapping("/whManage")
	@PostMapping
	@ResponseBody
	public int whManage2(WarehouseDetail regdata, String action, RedirectAttributes rdAttr){
		
		System.out.println(rdAttr.getFlashAttributes().get("whID"));
		
		logger.info("whID in RedirectAttributes...");
		logger.info(rdAttr);
		
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
