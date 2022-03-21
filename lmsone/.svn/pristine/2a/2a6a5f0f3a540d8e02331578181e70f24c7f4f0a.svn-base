package kr.happyjob.study.jmg.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
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

import kr.happyjob.study.common.comnUtils.ComnCodUtil;
import kr.happyjob.study.jmg.service.CareerInfoService;
import kr.happyjob.study.system.model.ComnGrpCodModel;

@Controller
@RequestMapping("/jmg/")
public class CareerInfoController {
	
	@Autowired
	CareerInfoService careerInfoService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	/**
	 * 취업정보 조회 초기화면
	 */
	@RequestMapping("careerInfo.do")
	public String initCareerInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".initCareerInfo");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".initCareerInfo");

		return "/jmg/careerInfo";
	}

	/**
	 * 취업정보 목록 출력
	 */
	@RequestMapping("listCareerInfo.do")
	public String listCareerInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".careerInfo");
		logger.info("   - paramMap : " + paramMap);
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;									// 페이지 시작 row 번호
				
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		// 취업정보 목록 조회
		List<Map<String, Object>> listCareerInfoMap = careerInfoService.listCareerInfo(paramMap);
		model.addAttribute("listCareerInfoMap", listCareerInfoMap);
		
		// 취업정보 목록 카운트 조회
		int totalCount = careerInfoService.totalCount(paramMap);
		model.addAttribute("totalCount", totalCount);
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPage",currentPage);
		
		logger.info("+ End " + className + ".careerInfo");
		

		return "/jmg/careerInfoList";
	}	
	
	
	/**
	 *  개인 취업정보 이력 조회
	 */
	@RequestMapping("careerDetail.do")
	@ResponseBody
	public Map<String, Object> careerDetail(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".careerDetail");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "조회되었습니다.";
		
		// 개인 취업정보 이력 조회
		List<Map<String, Object>> listCareerDtlMap = careerInfoService.careerDetail(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		int listSize = listCareerDtlMap.size();
		String uName = "";
		String outData = "";
		
		for (int i = 0; i < listSize; i++) {
			Map<String, Object> dtlMap = listCareerDtlMap.get(i);
			if (uName.equals("")) {
				uName = dtlMap.get("name") + "";
				resultMap.put("uName", uName);
			}
			outData += "<tr>" + "<td colspan='2' style='text-align:center;'>" + String.valueOf(dtlMap.get("corp")) + "</td>" + "<td colspan='2' style='text-align:center;'>" + String.valueOf(dtlMap.get("join_date")) + " ~ " + String.valueOf(dtlMap.get("resign_date")) + "</td>" + "</tr>"; 
		}
		
		resultMap.put("outData", outData);
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".careerDetail");
		
		return resultMap;
	}
}
