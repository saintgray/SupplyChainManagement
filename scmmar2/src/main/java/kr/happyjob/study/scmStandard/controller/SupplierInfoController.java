package kr.happyjob.study.scmStandard.controller;

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

import kr.happyjob.study.scmStandard.model.SupplierInfoModel;
import kr.happyjob.study.scmStandard.service.SupplierInfoService;


@Controller
@RequestMapping("/scmStandard/")
public class SupplierInfoController {
	
	@Autowired
	SupplierInfoService supplierInfoService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	   
	
	/**
	 * 납품업체정보 관리 초기화면
	 */
	@RequestMapping("supplierInfo.do")
	public String initSupplierInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".initSupplierInfo");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".initSupplierInfo");

		return "scmStandard/supplierInfo";
	}
	
	
	/**
	 * 납품업체정보 조회
	 */
	@RequestMapping("listSupplierInfo.do")
	public String listSupplierInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session,SupplierInfoModel supplierInfoModel) throws Exception {
		
		logger.info("+ Start " + className + ".listSupplierInfo");
		logger.info("   - paramMap : " + paramMap);		
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;									// 페이지 시작 row 번호
				
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);		
		
		// 납품업체정보 목록 조회
		List<SupplierInfoModel> listSupplierInfoModel = supplierInfoService.listSupplierInfo(paramMap);
		model.addAttribute("listSupplierInfoModel", listSupplierInfoModel);
		
		// 납품업체정보 목록 카운트 조회
		int totalCount = supplierInfoService.countListSupplierInfo(paramMap);
		model.addAttribute("totalCntSupplierInfo", totalCount);
		
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageSupplierInfo",currentPage);	
		
		logger.info("");
		
		logger.info("+ End " + className + ".listSupplierInfo");
		logger.info("==================================================================================");
		

		return "/scmStandard/supplierInfoList";
	}	
	
	/**
	 *  업체별 제품정보 목록 조회
	 */
	@RequestMapping("selectSupplierInfo.do")
	public String selectSupplierInfo (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectSupplierInfo");
		logger.info("   - paramMap : " + paramMap);

		// 공통 그룹 코드 단건 조회
		 List<SupplierInfoModel> supplierInfoModel = supplierInfoService.selectSupplierInfo(paramMap);
		
		model.addAttribute("supplierInfoModel",supplierInfoModel);
		
		logger.info("   - supplierProInfoList : " + supplierInfoModel);
		
		logger.info("+ End " + className + ".selectSupplierInfo");
		
		return "/scmStandard/supplierProInfoList";
	}
	
	

}
