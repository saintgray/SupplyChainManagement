package kr.happyjob.study.ged.controller;

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

import kr.happyjob.study.ged.model.SalesStatusModel;
import kr.happyjob.study.ged.service.SalesStatusService;

@Controller
@RequestMapping("/ged/")
public class SalesStatusController {
	
	@Autowired
	SalesStatusService salesStatusService;
	
    // Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	// 처음 로딩될 때 연결
	@RequestMapping("salesStatus.do")
	public String init(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".salesStatus");
		logger.info("   - paramMap : " + paramMap);
		
		String loginID = (String) session.getAttribute("loginId");
		paramMap.put("loginID", loginID);
		System.out.println(loginID);
//		paramMap.put("writer", loginID);
		
		return "ged/SalesStatus";
	}

	// 매출 리스트 출력
		@RequestMapping("salesStatusList.do")
		public String salesStatusList(Model model, @RequestParam Map<String, Object> paramMap, 
				HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".salesStatusList");
			logger.info("   - paramMap : " + paramMap);
			
			int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재페이지
		    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		    int pageIndex = (currentPage - 1) * pageSize;
			
			paramMap.put("pageIndex", pageIndex);
			paramMap.put("pageSize", pageSize);
			
			// 매출 목록 조회
			List<SalesStatusModel> salesStatusList = salesStatusService.SalesStatusList(paramMap);
			model.addAttribute("salesStatusList", salesStatusList);
			
			// 목록 수 추출해서 보내기
			int salesStatusCnt = salesStatusService.SalesStatusCnt(paramMap);
			
			model.addAttribute("salesStatusList", salesStatusList);
		    model.addAttribute("salesStatusCnt", salesStatusCnt);
		    model.addAttribute("pageSize", pageSize);
		    model.addAttribute("currentPage",currentPage);
		    System.out.println(salesStatusList);
		    return "ged/SalesStatusList";
		}
		
		@RequestMapping("salesStatusOne.do")
		public String salesStatusOne(Model model, @RequestParam Map<String, Object> paramMap, 
				HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".salesStatusList");
			logger.info("   - paramMap : " + paramMap);
			
			int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재페이지
		    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		    int pageIndex = (currentPage - 1) * pageSize;
			
			paramMap.put("pageIndex", pageIndex);
			paramMap.put("pageSize", pageSize);
			
			// 매출 목록 조회
			List<SalesStatusModel> salesStatus = salesStatusService.SalesStatusOne(paramMap);
			
			// 목록 수 추출해서 보내기
			int salesStatusCnt = salesStatusService.SalesStatusOneCnt(paramMap);
			
			model.addAttribute("salesStatusCnt", salesStatusCnt);
		    model.addAttribute("salesStatus", salesStatus);
		    model.addAttribute("pageSize", pageSize);
		    model.addAttribute("currentPage",currentPage);
		    System.out.println(salesStatus);
		    return "ged/SalesStatusOneList";
		}

}