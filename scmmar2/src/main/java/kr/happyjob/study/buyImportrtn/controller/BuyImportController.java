package kr.happyjob.study.buyImportrtn.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import kr.happyjob.study.buyImportrtn.model.BuyImport;
import kr.happyjob.study.buyImportrtn.service.BuyImportService;

@RequestMapping("/buyImport/")
@Controller
public class BuyImportController {
	
	@Autowired
	private BuyImportService service;
	
	private final Logger logger = LogManager.getLogger(this.getClass());
	private final String className = this.getClass().toString();
	
	/** 발주지시서 목록 초기화면 */
	@RequestMapping("purchaseOrder.do")
	public String buyImportPage( Model model
						  , @RequestParam Map<String, Object> paramMap
						  , HttpSession session
						  , HttpServletRequest request
						  , HttpServletResponse response ) throws Exception {
		logger.info(" #START : " + className + ".purchaseOrder");
		logger.info(" #Param :" + paramMap);
		logger.info(" #E N D : " + className + ".purchaseOrder");
		
		return "buyImportrtn/buyImport";
	}
	
	@RequestMapping("buyImportList.do")
	public String buyImportList( Model model
							   , @RequestParam Map<String, Object> paramMap
							   , HttpSession session
							   , HttpServletRequest request
							   , HttpServletResponse response ) throws Exception {
		logger.info(" #START : " + className + ".buyImportList");
		logger.info(" #Param :" + paramMap);
		
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageIndex = (currentPage - 1) * pageSize;
		paramMap.put("pageSize",pageSize);
		paramMap.put("pageIndex", pageIndex);
		
		List<BuyImport> items = service.selectImportList(paramMap);
		model.addAttribute("imports", items);
		
		int itemsTotal = service.selectImportTotal(paramMap);
		model.addAttribute("itemsTotal", itemsTotal);
		
		
		logger.info(" #E N D : " + className + ".buyImportList");
		return "buyImportrtn/buyImportList";
	}
	
	@RequestMapping("buyImportOne.do")
	@ResponseBody
	public Map<String, Object> buyImportOne( Model model
										   , @RequestParam Map<String, Object> paramMap
										   , HttpSession session
										   , HttpServletRequest request
										   , HttpServletResponse response ) throws Exception {
		
		BuyImport item = service.selectImportOne(paramMap);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("item", item);
		
		return resultMap;
	};
	
	@RequestMapping("updatePayY.do")
	@ResponseBody
	public Map<String, Object> updatePayY( 
										    @RequestParam Map<String, Object> paramMap
										   , HttpSession session
										   , HttpServletRequest request
										   , HttpServletResponse response ) throws Exception {
		
		int result = service.updatePayY(paramMap);

		String resultMsg = "";
		Map<String,Object> resultMap = new HashMap<String,Object>();
		
		
		if(result>0){
			resultMsg = "입금이 완료되었습니다.";
			resultMap.put("resultMsg", resultMsg);
			
		}else{
			resultMsg = "입금 실패";
			resultMap.put("resultMsg", resultMsg);
		}
		
		return resultMap;
	};

	
	@RequestMapping("returnInsert.do")
	@ResponseBody
	public Map<String, Object> returnInsert( 
										    @RequestParam Map<String, Object> paramMap
										   , HttpSession session
										   , HttpServletRequest request
										   , HttpServletResponse response ) throws Exception {
		
		int result = service.returnInsert(paramMap);

		String resultMsg = "";
		Map<String,Object> resultMap = new HashMap<String,Object>();
		
		
		if(result>0){
			resultMsg = "반품이 완료되었습니다.";
			resultMap.put("resultMsg", resultMsg);
			
		}else{
			resultMsg = "반품 실패";
			resultMap.put("resultMsg", resultMsg);
		}
		
		return resultMap;
	};

	
	
	
}
