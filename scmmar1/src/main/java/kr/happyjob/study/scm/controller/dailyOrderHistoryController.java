package kr.happyjob.study.scm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.scm.model.CompModel;
import kr.happyjob.study.scm.model.WorkOrderModel;
import kr.happyjob.study.scm.model.dailyOrderHistoryModel;
import kr.happyjob.study.scm.model.warehouseModel;
import kr.happyjob.study.scm.service.dailyOrderHistoryService;

@Controller
@RequestMapping("/scm/")
public class dailyOrderHistoryController {
	
	@Autowired
	dailyOrderHistoryService dailyorderhistoryservice;
	
	// 화면 이동
	@RequestMapping("dailyOrderHistory.do")
	public String initApproval(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {
		return "scm/dailyOrderHistory";
	}
	
	
	 @RequestMapping("listdailyOrderHistory.do")
	 public String gouppcodelist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      
	      int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
	      int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
	      int pageIndex = (currentPage-1)*pageSize;
	      
	      paramMap.put("pageIndex", pageIndex);	
	      paramMap.put("pageSize", pageSize);
	      
	      int total = dailyorderhistoryservice.total(paramMap);
	      List<dailyOrderHistoryModel> listdailyOrderHistory = dailyorderhistoryservice.listdailyOrderHistory(paramMap);
	      
	      
	      System.out.println("pur_id123 : " + paramMap.get("pur_id"));
	      
	      model.addAttribute("total",total);
	      model.addAttribute("listdailyOrderHistory",listdailyOrderHistory);
	      
	      
	      return "scm/dailyOrderHistorylist";
	   }  
	
	 @RequestMapping("onedailyOrderHistory.do")
	 public String onedailyOrderHistory(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception{
		 
		 String returnjsp = "";
		 int selcheck = Integer.parseInt(String.valueOf(paramMap.get("selcheck")));
		 System.out.println("pur_id : " + paramMap.get("pur_id"));
		 
 		 if(selcheck == 1){
 			returnjsp = "scm/layer22";
		 }else if (selcheck == 2){
			 returnjsp = "scm/layer33";
			
		 }else{
			 returnjsp = "scm/layer44";
		 }	 
 		 
 		 List<warehouseModel> warehouse = dailyorderhistoryservice.warehouse();
		 WorkOrderModel onedailyOrderHistory = dailyorderhistoryservice.onedailyOrderHistory(paramMap);
		 List<CompModel> comp = dailyorderhistoryservice.comp();
		 
		 model.addAttribute("onedata",onedailyOrderHistory);
		 model.addAttribute("warehouse",warehouse);
		 model.addAttribute("comp",comp);
		 
		 return returnjsp;
	 }
	
	 @RequestMapping("whcnd.do")
	 @ResponseBody
	 public Map<String,Object> gouppcodelistvue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	     HttpServletResponse response, HttpSession session) throws Exception{
		 
		 warehouseModel whcnt = dailyorderhistoryservice.whcnt(paramMap);
		 System.out.println("sales_id : " + paramMap.get("sales_id"));
		 System.out.println("wh_id : " + paramMap.get("wh_id"));
		 System.out.println("whcnt : " + whcnt.getSt_cnt());
		 
		 Map<String,Object> returnmap = new HashMap<String,Object>();
		 
		 returnmap.put("whcnt", whcnt); 
		 
		 
	      return returnmap;
		 
	 }
	
	 @RequestMapping("sendtotal.do")
	 @ResponseBody
	 public Map<String,Object> insert(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
		     HttpServletResponse response, HttpSession session) throws Exception{
		 System.out.println("active : "+paramMap.get("active"));
		 System.out.println("com_cnt : "+paramMap.get("com_cnt"));
		 System.out.println("sales_id : "+paramMap.get("sales_id"));
		 System.out.println("com_code : "+paramMap.get("com_code"));
		 
		 String act = (String) paramMap.get("active");
		 
		 
		 if(act.equals("com")){
			 dailyorderhistoryservice.insertcom1(paramMap);
			 dailyorderhistoryservice.insertcom2(paramMap);
		 }
		 
		 
		 Map<String,Object> returnmap = new HashMap<String,Object>();
		 
		 
		 
	      return returnmap;
	 }
	
	
	
	
	
	
	
	
	
	
	
	
	
}
