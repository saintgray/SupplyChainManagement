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
import kr.happyjob.study.buyImportrtn.model.BuyImportReturn;
import kr.happyjob.study.buyImportrtn.service.BuyImportReturnService;

@RequestMapping("/buyImport/")
@Controller
public class BuyImportReturnController {
	
	@Autowired
	private BuyImportReturnService service;
	
	private final Logger logger = LogManager.getLogger(this.getClass());
	private final String className = this.getClass().toString();
	
	/** 반품지시서 목록 초기화면 */
	@RequestMapping("returnPurchase.do")
	public String refundPage( Model model
							  , @RequestParam Map<String, Object> paramMap
							  , HttpSession session
							  , HttpServletRequest request
							  , HttpServletResponse response ) throws Exception {
		logger.info(" #START : " + className + ".purchaseOrder");
		logger.info(" #Param :" + paramMap);
		logger.info(" #E N D : " + className + ".purchaseOrder");
		
		return "buyImportrtn/buyImpRefund";
	}
	
	/** 반품목록조회 */
	@RequestMapping("getRefundList.do")
	public String getRefundList( Model model
						  , @RequestParam Map<String, Object> paramMap
						  , HttpSession session
						  , HttpServletRequest request
						  , HttpServletResponse response ) throws Exception {
		logger.info(" #START : " + className + ".getRefundList");
		logger.info(" #Param :" + paramMap);
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageIndex = (currentPage - 1) * pageSize;
		paramMap.put("pageSize",pageSize);
		paramMap.put("pageIndex", pageIndex);		
		
		List<BuyImportReturn> items = service.getReturnList(paramMap);
		int itemsTotal = service.getReturnTotal(paramMap);
		model.addAttribute("items", items);
		model.addAttribute("RefundTotal", itemsTotal);

		logger.info(" #E N D : " + className + ".getRefundList");
		return "buyImportrtn/buyImpRefundList";
	}
	
	/** 반품단건조회 */
	@RequestMapping("getRefundOne.do")
	@ResponseBody
	public Map<String, Object> getRefundOne( Model model
										   , @RequestParam Map<String, Object> paramMap
										   , HttpSession session
										   , HttpServletRequest request
										   , HttpServletResponse response ) throws Exception {
		
		BuyImportReturn item = service.getReturnOne(paramMap);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("item", item);
		
		return resultMap;
	};

	

}
