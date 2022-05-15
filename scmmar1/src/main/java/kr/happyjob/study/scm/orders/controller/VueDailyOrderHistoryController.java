package kr.happyjob.study.scm.orders.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.happyjob.study.scm.orders.model.DailyOrderHistoryModel;
import kr.happyjob.study.scm.orders.model.WorkOrderModel;
import kr.happyjob.study.scm.orders.model.warehouseModel;
import kr.happyjob.study.scm.orders.model.whcntModel;
import kr.happyjob.study.scm.orders.service.DailyOrderHistoryService;
import kr.happyjob.study.scm.orders.service.whInventoryFormService;
import kr.happyjob.study.scm.sales.service.SalesManageService;
import kr.happyjob.study.scm.supplier.service.SupplyManageService;
import kr.happyjob.study.scm.user.service.UserInfoService;

@RestController
@RequestMapping("/scm/vue")
public class VueDailyOrderHistoryController {
	
	private Logger logger = LogManager.getLogger(this.getClass());
	
	
	private DailyOrderHistoryService dailyorderhistoryservice;
	private whInventoryFormService wiService;
	private UserInfoService uiService;
	private SalesManageService smService;
	private SupplyManageService supplyService;
	
	public VueDailyOrderHistoryController() {
	
	}

	
	
	@Autowired
	public VueDailyOrderHistoryController(DailyOrderHistoryService dailyorderhistoryservice,
			whInventoryFormService wiService, UserInfoService uiService, SalesManageService smService,
			SupplyManageService supplyService) {

		this.dailyorderhistoryservice = dailyorderhistoryservice;
		this.wiService = wiService;
		this.uiService = uiService;
		this.smService = smService;
		this.supplyService = supplyService;
	}




	// 수주 내역 
	 @PostMapping("/dailyorders")
	 public Map<String,Object> Initlist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      logger.info("--currentPage"+paramMap.get("currentPage").toString());
	      int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
	      int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
	      int pageIndex = (currentPage-1)*pageSize;
	      int totalPage=Integer.parseInt((String)paramMap.get("totalPage"));
	      
	      paramMap.put("pageIndex", pageIndex);	
	      paramMap.put("pageSize", pageSize);
	      
	      logger.info("+ paramMap"+ paramMap);
	      
	      
	      int total = dailyorderhistoryservice.total(paramMap);
	  
	      
	      Map<String, Object> result=new HashMap<>();
	      
	      if(total>0){
	    	  
	    	  List<DailyOrderHistoryModel> listdailyOrderHistory = dailyorderhistoryservice.listdailyOrderHistory(paramMap);
		      
		      
	    	  if(total>totalPage){
	    		  totalPage=total/pageSize;
	    		  totalPage=totalPage%pageSize >0? totalPage+1 : totalPage;
	    	  }
		      
		      
		      result.put("orders", listdailyOrderHistory);

	      }
	      result.put("currentPage",currentPage);
	      result.put("pageSize",pageSize);
	      result.put("total", total);
	      result.put("totalPage",totalPage);
	      // result.put("selectsearch",paramMap.get("selectsearch").toString());
//	      result.put("typeByRef", paramMap.get("typeByRef").toString());
//	      result.put("typeByDate", paramMap.get("typeByDate").toString());
	      // result.put("dateSearch1",paramMap.get("dateSearch1").toString());
	      // result.put("dateSearch2",paramMap.get("dateSearch2").toString());
	      
	      
	      
	      
	      return result;
	   }
	 
	 // 주문 상세 보기
	 @PostMapping("/order/{idx}")
	 public Map<String,Object> getOrderInfo(@PathVariable String idx){
		 
		 Map<String, Object> paramMap =new HashMap<>();
		 Map<String,Object> result=new HashMap<>();
		 paramMap.put("pur_id", idx);
		 
		 
		 List<WorkOrderModel> infoList=null;
		 try {
				 infoList=dailyorderhistoryservice.onedailyOrderHistory(paramMap);
				 result.put("infoList",infoList);
				 // model.addAttribute("infoList",infoList);
				 if(infoList!=null && !infoList.isEmpty()){
					 result.put("depositYN", infoList.get(0).getDepositYN());
					 // model.addAttribute("depositYN", infoList.get(0).getDepositYN());
				 }
			 
		} catch (Exception e) {
			e.printStackTrace();
		}
		 
		return result; 
	 }

	 
		
		
	// 구매한 상품당 재고를 가진 창고와 유효재고수를 보여주어야 할 때는 고객이 상품을 주문했을 때이다.
	// 회사가 납품업체에게 상품을 발주하는 경우에는 모든 창고를,
	// 고객이 회사에게 반품하는 경우에는 모든 창고를,
	// 회사가 납품업체에게 상품을 반품하는 경우에는 창고를 보여주지 않아도 된다.
	@PostMapping("/dir/{formType}/{idx}")
	public Map<String,Object> getDataForDirForm(@PathVariable String formType, @PathVariable String idx, HttpSession session, Model model){
		

		String purchaserUserType= uiService.getUserInfo(null,idx).getUser_Type();
		
		Map<String,Object> result= new HashMap<>();
		
		
		if(purchaserUserType.equals("C") && formType.toLowerCase().equals("shippingdir")){

			Map<String,List<whcntModel>> listOfValidStockList=new HashMap<>();
			List<whcntModel> validStockList=null;
			
			try{
				validStockList=wiService.getValidWareHouse(idx,purchaserUserType);
				
				
				int lastIndex=0;
				for(int i=0; i<validStockList.size(); i++){
					
					if(i!=0){
						if(!(validStockList.get(i).getSales_id().equals(validStockList.get(i-1).getSales_id()))){
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
				result.put("list", listOfValidStockList);
				//model.addAttribute("list",listOfValidStockList);
			}catch(Exception e){
				e.printStackTrace();
			}
			
		}else{
			// targetView="scm/orders/system/dirSelectBox";
			logger.info("+ start search sales_id ref pur_id :" + idx);
			
			try {
				List<String> salesIdAndNameList=smService.selectAllPurchaseInfoByIdx(idx,purchaserUserType);
				
				
				List<List<String>> salesInfoList=new LinkedList<List<String>>();
				
				for(String str : salesIdAndNameList){
					salesInfoList.add(Arrays.asList(str.split(",")));
				}
				
				// salesIdAndNameList 에는 고객이 주문한 주문번호에 해당하는 모든 구매상세번호,상품명 쌍을 가져온다
				// saleInfoList 에 구매상세번호,상품명 문자열 쌍을 배열로 쪼개어 넣는다.
				// 1번 상품의 이름이 abc 라면
				// salesInfoList 안의 List<String> 요소는 [1,abc] 가 된다.
				
				result.put("listOfSalesInfoList", salesInfoList);
				// 창고선택을 위한 Combobox도 가져온다.
				result.put("supplyList", supplyService.getComnCod());
				// model.addAttribute("listOfSalesInfoList", salesInfoList);
				// logger.info(salesInfoList);
			} catch (Exception e) {
				
				e.printStackTrace();
			}
	
		}
		return result;
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
