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
import kr.happyjob.study.scm.model.DailyOrderHistoryModel;
import kr.happyjob.study.scm.model.WorkOrderModel;
import kr.happyjob.study.scm.model.warehouseModel;
import kr.happyjob.study.scm.service.DailyOrderHistoryService;

@Controller
@RequestMapping("/scm/")
public class DailyOrderHistoryController {
	
	@Autowired
	DailyOrderHistoryService dailyorderhistoryservice;
	
	// 화면 이동
	@RequestMapping("dailyOrderHistory.do")
	public String InitApproval(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {
		return "scm/dailyOrderHistory";
	}
	
	 @RequestMapping("listdailyOrderHistory.do")
	 public String Initlist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      
	      int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
	      int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
	      int pageIndex = (currentPage-1)*pageSize;
	      
	      paramMap.put("pageIndex", pageIndex);	
	      paramMap.put("pageSize", pageSize);
	      
	      List<DailyOrderHistoryModel> listdailyOrderHistory = dailyorderhistoryservice.listdailyOrderHistory(paramMap);
	      int total = dailyorderhistoryservice.total(paramMap);
	      System.out.println("pur_id123 : " + paramMap.get("pur_id"));
	      
	      model.addAttribute("listdailyOrderHistory",listdailyOrderHistory);
	      model.addAttribute("total",total);
	      
	      
	      return "scm/dailyOrderHistorylist";
	   }  

	 @RequestMapping("onedailyOrderHistory.do")
	 public String OnedailyOrderHistory(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception{
		 
		 String returnjsp = "";
		 int selcheck = Integer.parseInt(String.valueOf(paramMap.get("selcheck")));
		 System.out.println("pur_id : " + paramMap.get("pur_id"));
		 
 		 if(selcheck == 1){
 			returnjsp = "scm/layer22";
 			System.out.println(selcheck);
		 }else if (selcheck == 2){
			 returnjsp = "scm/layer33";
			 System.out.println(selcheck);
		 }else {
			 returnjsp = "scm/layer44";
			 System.out.println(selcheck);
		 }	 
 		 
 		 List<warehouseModel> warehouse = dailyorderhistoryservice.warehouse();
		 WorkOrderModel onedailyOrderHistory = dailyorderhistoryservice.onedailyOrderHistory(paramMap);
		 List<CompModel> comp = dailyorderhistoryservice.comp();
		 DailyOrderHistoryModel comf = dailyorderhistoryservice.comf(paramMap);
		 DailyOrderHistoryModel come = dailyorderhistoryservice.come(paramMap);
		 
		 String comfp = "";
		 String comfg = "";
		 
		 if(comf == null){
			 comfp = "N";
			 model.addAttribute("comfp",comfp);
		 }else{
			 comfp = "Y";
			 model.addAttribute("comfp",comfp);
		 }
		 
		 if(come == null){
			 comfg = "N";
			 model.addAttribute("comfg",comfg);
		 }else{
			 comfg = "Y";
			 model.addAttribute("comfg",comfg);
		 }
				 
				 
		 System.out.println("comf : " + comf);
		 System.out.println("come : " + come);
		 System.out.println("onedailyOrderHistory : " + onedailyOrderHistory);
		 
		 model.addAttribute("onedata",onedailyOrderHistory);
		 model.addAttribute("warehouse",warehouse);
		 model.addAttribute("comp",comp);
		 
		 
		 return returnjsp;
	 }
	
	 @RequestMapping("whcnd.do")
	 @ResponseBody
	 public Map<String,Object> Whlist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	     HttpServletResponse response, HttpSession session) throws Exception{
		 
		 warehouseModel whcnt = dailyorderhistoryservice.whcnt(paramMap);
		 Map<String,Object> returnmap = new HashMap<String,Object>();
		 String msg = "이 창고는 재고 준비중 입니다";
		 //System.out.println("sales_id : " + paramMap.get("sales_id"));
		 //System.out.println("wh_id : " + paramMap.get("wh_id"));
		 //System.out.println("whcnt : " + whcnt.getSt_cnt());
			
		 	returnmap.put("whcnt", whcnt); 
			returnmap.put("msg", msg);
		
	      return returnmap;
		 
	 }
	
	 @RequestMapping("sendtotal.do")
	 @ResponseBody
	 public Map<String,Object> Insert(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
		     HttpServletResponse response, HttpSession session) throws Exception{
		 System.out.println("active : "+paramMap.get("active"));
		 System.out.println("com_cnt : "+paramMap.get("com_cnt"));
		 System.out.println("sales_id : "+paramMap.get("sales_id"));
		 System.out.println("com_code : "+paramMap.get("com_code"));
		 System.out.println("com_code : "+paramMap.get("wh_id"));
		 
		 Map<String,Object> returnmap = new HashMap<String,Object>();
		 String act = (String) paramMap.get("active");
		 String msg = "";
		 int a = 0;
		 //발주 지시서 
		 if(act.equals("com")){
			 paramMap.put("fk", "");
			 a = dailyorderhistoryservice.insertcom2(paramMap);
			
			 System.out.println("insertcom2 return : " + a);
			 if(a == 1){
				 dailyorderhistoryservice.insertcom1(paramMap);
				 msg = "발주 신청 완료";
				 returnmap.put("msg", msg);
			 }
			 
			 
		 //반품 지시서	 
		 }else if(act.equals("re")){
			 a = dailyorderhistoryservice.insertreturn(paramMap);
			 if(a == 1){
				 msg = "반품 신청 완료";
				 returnmap.put("msg", msg);
			 }
			 
			 
		 //배송 지시서
		 }else if(act.equals("wa")){
			 a = dailyorderhistoryservice.insertdel(paramMap);
			 if(a == 1){
				 msg = "배송 신청 완료";
				 returnmap.put("msg", msg);
			 }
		 }
		
	      return returnmap;
	 }
	
	
	
	
	
	
	
	
	
	
	
	
	
}