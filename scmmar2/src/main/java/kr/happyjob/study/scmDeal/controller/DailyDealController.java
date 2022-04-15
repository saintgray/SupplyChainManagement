package kr.happyjob.study.scmDeal.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.scmDeal.model.DailyDeal;
import kr.happyjob.study.scmDeal.service.DaliyDealService;

@Controller
@RequestMapping("/scmDeal/")
public class DailyDealController {
	
	@Autowired
	private DaliyDealService daliyDealService;
	
	// Set Logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get className for logger
	private final String className = this.getClass().toString();	
	
	/** 일별수주내역 초기화면 */
	@RequestMapping("dailyOrderHistory.do")
	public String dailyDealPage( Model model
							   , @RequestParam Map<String, Object> paramMap
							   , HttpSession session	
							   , HttpServletRequest request
							   , HttpServletResponse response ) throws Exception {
		logger.info(" #Start: " + className + ".dailyDealPage");
		logger.info(" #Param: " + paramMap);
				
		/** 배송담당 직원 목록 조회 */
		List<DailyDeal> items = daliyDealService.getDeliveryMen(paramMap);
		model.addAttribute("employees", items);
		/** 창고 목록 조회 */
		List<DailyDeal> whItems = daliyDealService.getWarhouses(paramMap);
		model.addAttribute("warehouses", whItems);
		/** 납품회사 목록 조회 */
		List<DailyDeal> comList = daliyDealService.getComList(paramMap);
		model.addAttribute("comList", comList);
		System.out.println(comList.toString());
		
		logger.info(" #E N D: " + className + ".dailyDealPage");
		return "scmDeal/dailyDealMain";
	}
	
	/** 수주 목록 조회 */
	@RequestMapping("getList.do")
	public String getList( Model model
					 	 , @RequestParam Map<String, Object> paramMap
						 , HttpSession session
						 , HttpServletRequest request
						 , HttpServletResponse response ) throws Exception {
		logger.info(" #Start: " + className + ".getList");
		logger.info(" #Param: " + paramMap);
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));
		int pagePostNum = Integer.parseInt((String)paramMap.get("pagePostNum"));
		int pageNumber  = (currentPage - 1) * pagePostNum;
		
		paramMap.put("pagePostNum", pagePostNum);
		paramMap.put("pageNumber", pageNumber);
		
		List<DailyDeal> items = daliyDealService.getList(paramMap);
		model.addAttribute("dailyDealData", items);
		
		int totalCount = daliyDealService.getTotalCount(paramMap);
		model.addAttribute("totalCount", totalCount);
		
		logger.info(" #E N D: " + className + ".getList");
		return "scmDeal/dailyDealData";
	}
	
	/** 수주 단건 조회 */
	@RequestMapping("getOne.do")
	@ResponseBody
	public Map<String, Object> getOne( Model model
								 	 , @RequestParam Map<String, Object> paramMap
									 , HttpSession session
									 , HttpServletRequest request
									 , HttpServletResponse response ) throws Exception {

		logger.info(" #Start: " + className + ".getOne");
		logger.info(" #Param: " + paramMap);
		
		DailyDeal item = daliyDealService.getOne(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>() ;
		//map자체를 데이터로 보냄
		resultMap.put("item", item);
		
		logger.info(" #E N D: " + className + ".getOne");
		return resultMap;
	}
	
	/** 2) 창고별 제품 목록 조회 */
	@RequestMapping("getProductList.do")
	@ResponseBody
	public Map<String, Object> getProductList( Model model
											 , @RequestParam Map<String, Object> paramMap
											 , HttpSession session
											 , HttpServletRequest request
											 , HttpServletResponse response ) throws Exception {

		logger.info(" #Start: " + className + ".getProductList");
		logger.info(" #Param: " + paramMap);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<DailyDeal> pdList = daliyDealService.getProductList(paramMap);
		resultMap.put("pdList", pdList);
		
		int whcode = Integer.parseInt((String) paramMap.get("whcode"));
		resultMap.put("whcode", whcode);
		
		/** 3) 장고별 제품별 재고수량 조회 */
		int getStTotalCount = daliyDealService.getStTotalCount(paramMap);
		resultMap.put("stTotal", getStTotalCount);
		
		logger.info(" #E N D: " + className + ".getProductList");
		return resultMap;
	}	
	
	@RequestMapping("saveDeliveryInfo.do")
	@ResponseBody
	public Map<String, Object> saveDeliveryInfo( Model model
											   , @RequestParam Map<String, Object> paramMap
											   , HttpSession session
											   , HttpServletRequest request
											   , HttpServletResponse response ) throws Exception {
		logger.info(" #Start: " + className + ".saveDeliveryInfo");
		logger.info(" #Param: " + paramMap);
		
		/* 동적태그(tr)로 생긴 데이터들을 한번에 insert 할 때
		 * 1. 총 건수를 넘겨 받아서
		 * 2. for문을 통해서 총 건수만큼 돌려서
		 * 3. Map객체로 받은 파라미터들을 형변환 후
		 * 4. 해당 건에 대해서만 insert를 실행 */
		
		int totalDelInfoCnt = Integer.parseInt((String) paramMap.get("totalDelInfoCnt"));
		String getWarehouse = "";
		int getIdxWarehouse = 0;
		String getPdmdno = "";
		int getStCntModal = 0;
		int getOddtdelcnt = 0;
		
		for( int i = 1; i <= totalDelInfoCnt ; i++) {
			if(i == 1) {
				System.out.println("if");
				//창고번호
				getWarehouse = "warehouse";
				getIdxWarehouse = Integer.parseInt((String) paramMap.get(getWarehouse));
				paramMap.put("warehouse", getIdxWarehouse);
				
				//모델PK
				getPdmdno = (String) paramMap.get("pdmdno");
				paramMap.put("pdmdno", getPdmdno);
				
				//재고량
				getStCntModal = Integer.parseInt((String) paramMap.get("stCntforModal"));
				paramMap.put("stCntforModal", getStCntModal);
				
				//주문개수
				getOddtdelcnt = Integer.parseInt((String) paramMap.get("oddtdelcnt"));
				paramMap.put("oddtdelcnt", getOddtdelcnt);
				
				System.out.println("파라미터 : " + paramMap);
				
			} else {
				System.out.println("else");
				//창고번호
				getWarehouse = "warehouse" + String.valueOf(i);
				getIdxWarehouse = Integer.parseInt((String) paramMap.get(getWarehouse));
				paramMap.put("warehouse", getIdxWarehouse);
				
				//모델PK
				getPdmdno = (String) paramMap.get("pdmdno" + String.valueOf(i));
				paramMap.put("pdmdno", getPdmdno);
				
				//재고량
				getStCntModal = Integer.parseInt((String) paramMap.get("stCntforModal" + String.valueOf(i)));
				paramMap.put("stCntforModal", getStCntModal);
				
				//주문개수
				getOddtdelcnt = Integer.parseInt((String) paramMap.get("oddtdelcnt" + String.valueOf(i)));
				paramMap.put("oddtdelcnt", getOddtdelcnt); 
				
				System.out.println("파라미터 : " + paramMap);
			}
			daliyDealService.saveDeliveryInfo(paramMap);
		}
		logger.info(" #E N D: " + className + ".saveDeliveryInfo");
		return paramMap;
	}
	
	@RequestMapping("saveImportsInfo.do")
	@ResponseBody
	public Map<String, Object> saveImportsInfo( Model model
										      , @RequestParam Map<String, Object> paramMap
										      , HttpSession session
										      , HttpServletRequest request
										      , HttpServletResponse response ) throws Exception {
		
		String logicResult = "FALSE";
		String resultMsg = "알수 없는 요청입니다.";
		
		//사용자 ID가져오기
		paramMap.put("userID", session.getAttribute("loginId"));
		System.out.println((String) paramMap.get("userID"));
		
		System.out.println("#######################"+paramMap);
		
		int saveResult = daliyDealService.saveImport(paramMap);	
		
		if(saveResult>0){
			daliyDealService.saveImportDetai(paramMap);
			logicResult = "SUCCESS";
			resultMsg = "저장 되었습니다.";
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("logicResult", logicResult);
		resultMap.put("resultMsg", resultMsg);
		
		return resultMap;
	}
	
}
