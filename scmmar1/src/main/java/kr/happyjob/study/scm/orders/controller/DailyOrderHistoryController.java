package kr.happyjob.study.scm.orders.controller;


import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.scm.orders.model.DailyOrderHistoryModel;
import kr.happyjob.study.scm.orders.model.WorkOrderModel;
import kr.happyjob.study.scm.orders.model.warehouseModel;
import kr.happyjob.study.scm.orders.model.whcntModel;
import kr.happyjob.study.scm.orders.service.DailyOrderHistoryService;
import kr.happyjob.study.scm.orders.service.whInventoryFormService;
import kr.happyjob.study.scm.sales.service.SalesManageService;
import kr.happyjob.study.scm.user.service.UserInfoService;

@Controller
@RequestMapping("/scm/")
public class DailyOrderHistoryController {
	
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	
	private DailyOrderHistoryService dailyorderhistoryservice;
	private whInventoryFormService wiService;
	private UserInfoService uiService;
	private SalesManageService smService;
	
	public DailyOrderHistoryController() {
		
	}

	@Autowired
	 public DailyOrderHistoryController(DailyOrderHistoryService dailyorderhistoryservice,
				whInventoryFormService wiService, UserInfoService uiService, SalesManageService smService) {
			
			this.dailyorderhistoryservice = dailyorderhistoryservice;
			this.wiService = wiService;
			this.uiService = uiService;
			this.smService = smService;
	}
	








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
	 @PostMapping
	 public String getOrderInfo(@PathVariable String idx,Model model){
		 
		 Map<String, Object> paramMap =new HashMap<>();
		 paramMap.put("pur_id", idx);
		 
		 
		 List<WorkOrderModel> infoList=null;
		 try {
				 infoList=dailyorderhistoryservice.onedailyOrderHistory(paramMap);
				 model.addAttribute("infoList",infoList);
				 if(infoList!=null && !infoList.isEmpty()){
					 model.addAttribute("depositYN", infoList.get(0).getDepositYN());
				 }
			 
			 
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
		}finally{
			
			model.addAttribute("pur_id",idx);
			
		}
		return "scm/orders/system/orderInfo"; 
	 }

	@RequestMapping("/callDirForm/{formType}/{idx}")
	@PostMapping
	public String getDataForDirForm(@PathVariable String formType, @PathVariable String idx, HttpSession session, Model model){
		
		String targetView="";
		
		logger.info("+ initiate getDataForDirForm.....");
		
		
		
		// 구매한 상품당 재고를 가진 창고와 유효재고수를 보여주어야 할 때는 고객이 상품을 주문했을 때이다.
		// 회사가 납품업체에게 상품을 발주하는 경우에는 모든 창고를,
		// 고객이 회사에게 반품하는 경우에는 모든 창고를,
		// 회사가 납품업체에게 상품을 반품하는 경우에는 창고를 보여주지 않아도 된다.
		
		logger.info("+ pur_id : "+idx);
		logger.info("+ formType : "+formType);
		
		
		Map<String,List<whcntModel>> listOfValidStockList=new HashMap<>();
		List<whcntModel> validStockList=null;
		String purchaserUserType= uiService.getUserInfo(null,idx).getUser_Type();
		
		
		if(purchaserUserType.equals("C") && formType.toLowerCase().equals("shippingdir")){
			targetView="scm/orders/system/validStockList";
			try{
				validStockList=wiService.getValidWareHouse(idx,purchaserUserType);
				
				
				int lastIndex=0;
				for(int i=0; i<validStockList.size(); i++){
					
//					logger.info("+ lastIndex : "+lastIndex);
//					logger.info("+ now sales id :" + validStockList.get(i).getSales_id());
					if(i!=0){
						if(!(validStockList.get(i).getSales_id().equals(validStockList.get(i-1).getSales_id()))){
//							logger.info("+ now i val : "+i+ " now sales_id val : " + validStockList.get(i).getSales_id());
//							logger.info("prev i val : "+ (i-1)+" prev sales_id val : " + validStockList.get(i-1).getSales_id());
							
							// 최소 2개 이상의 창고가 해당 상품을 가지고 있었을 경우
							if(i-1!=lastIndex){
								listOfValidStockList.put(String.valueOf(validStockList.get(i-1).getSales_nm()),
										validStockList.subList(lastIndex, i-1));
							// 단 하나의 창고만 해당 상품을 가지고 있었을 경우
							}else{
								List<whcntModel> list=new ArrayList<>();
								list.add(validStockList.get(i-1));
								listOfValidStockList.put(String.valueOf(validStockList.get(i-1).getSales_nm()),list);
							}			
							lastIndex=i;
						}
						
						if(i==validStockList.size()-1){
							if(i==lastIndex){
								List<whcntModel> list=new ArrayList<>();
								list.add(validStockList.get(i));
								listOfValidStockList.put(String.valueOf(validStockList.get(i).getSales_nm()),list);
							}else{
								listOfValidStockList.put(String.valueOf(validStockList.get(i).getSales_nm()),
										validStockList.subList(lastIndex, i));
							}
						}
					}
				}
				logger.info("+ map result " + listOfValidStockList);
				model.addAttribute("list",listOfValidStockList);
			}catch(Exception e){
				e.printStackTrace();
			}
			
		}else{
			targetView="scm/orders/system/dirSelectBox";
			logger.info("+ start search sales_id ref pur_id :" + idx);
			
			try {
				List<String> salesIdAndNameList=smService.selectAllPurchaseInfoByIdx(idx,purchaserUserType);
				
				
				List<List<String>> salesInfoList=new LinkedList<List<String>>();
				
				for(String str : salesIdAndNameList){
					salesInfoList.add(Arrays.asList(str.split(",")));
				}
				
				model.addAttribute("listOfSalesInfoList", salesInfoList);
				logger.info(salesInfoList);
			} catch (Exception e) {
				
				e.printStackTrace();
			}
			
			
		}
		
		
		return targetView;
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