package kr.happyjob.study.scm.orders.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.scm.orders.model.CompModel;
import kr.happyjob.study.scm.orders.model.DailyOrderHistoryModel;
import kr.happyjob.study.scm.orders.model.WorkOrderModel;
import kr.happyjob.study.scm.orders.model.warehouseModel;
import kr.happyjob.study.scm.orders.service.DailyOrderHistoryService;

@Controller
@RequestMapping("/scm/")
public class DailyOrderHistoryController {
	
	@Autowired
	DailyOrderHistoryService dailyorderhistoryservice;
	
	// 화면 이동
	@RequestMapping("dailyOrderHistory.do")
	public String InitApproval(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {
		return "scm/orders/dailyOrderHistory";
	}
	
	 // 수주 내역 
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
	      
	      
	      return "scm/orders/system/dailyOrderHistorylist";
	   }
	 
	 // 주문 상세 보기
	 @RequestMapping("/purchaseinfo/{idx}")
	 public String getOrderInfo(@PathVariable String idx,Model model){
		 
		 Map<String, Object> paramMap =new HashMap<>();
		 paramMap.put("pur_id", idx);
		 
		 
		 List<WorkOrderModel> infoList=null;
		 try {
			 infoList=dailyorderhistoryservice.onedailyOrderHistory(paramMap);
			 model.addAttribute("infoList",infoList);
			 model.addAttribute("depositYN", infoList.get(0).getDepositYN());
			 
			 // 구매한 상품중 반품요청이 하나라도 있다면 Model 객체에 반품요청이 있다는 flag 를 추가한다
			 model.addAttribute("flagReturnYN","N");
			 for(WorkOrderModel orderItem : infoList){
				 if(orderItem.getReturnYN().equals("Y")){
					 model.addAttribute("flagReturnYN","Y");
					 break;
				 }
			 }
			 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "scm/orders/system/orderInfo"; 
	 }

	 @RequestMapping("onedailyOrderHistory.do")
	 public String getPurchaseInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception{
		 
		 // target jsp path
		 String returnjsp = "";
		 
		 int selcheck = Integer.parseInt(String.valueOf(paramMap.get("selcheck")));
		 
		 
		 switch(selcheck){
		 case 1:
			 returnjsp="scm/orders/system/layer22";
			 break;
		 case 2:
			 returnjsp="scm/orders/system/layer33";
			 break;
		 case 3:
			 returnjsp="scm/orders/system/layer44";
			 break;
		 }
 		
 		 
 		 List<warehouseModel> warehouse = dailyorderhistoryservice.warehouse();
		 List<WorkOrderModel> onedailyOrderHistory = dailyorderhistoryservice.onedailyOrderHistory(paramMap);
		 List<CompModel> comp = dailyorderhistoryservice.comp();
		 DailyOrderHistoryModel comf = dailyorderhistoryservice.comf(paramMap);
		 DailyOrderHistoryModel come = dailyorderhistoryservice.come(paramMap);
		 
		 
		 // 반품지시서? 관련
		 if(comf == null){
			 model.addAttribute("comfp","N");
		 }else{
			 model.addAttribute("comfp","Y");
		 }
		   
		 if(come == null){
			 model.addAttribute("comfg","N");
		 }else{
			 model.addAttribute("comfg","Y");
		 }
		 model.addAttribute("infoList",onedailyOrderHistory);
		 model.addAttribute("warehouse",warehouse);
		 model.addAttribute("comp",comp);
		 
		 model.addAttribute("depositYN",onedailyOrderHistory.get(0).getDepositYN());
		 return returnjsp;
	 }
	
	 @RequestMapping("whcnd.do")
	 @ResponseBody
	 public Map<String,Object> Whlist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	     HttpServletResponse response, HttpSession session) throws Exception{
		 
		 warehouseModel whcnt = dailyorderhistoryservice.whcnt(paramMap);
		 Map<String,Object> returnmap = new HashMap<String,Object>();
		 String msg = "이 창고는 재고 준비중 입니다";
		 
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
			 try {
				 a = dailyorderhistoryservice.insertreturn(paramMap);
				 if(a == 1){
					 msg = "반품 신청 완료";
					 returnmap.put("msg", msg);
				 }
			} catch (Exception e) {
					msg = "반품 수량이 없습니다. ";
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