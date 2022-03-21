package kr.happyjob.study.mng.controller;

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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.common.comnUtils.ComnCodUtil;
import kr.happyjob.study.mng.service.ExamMemberService;

@Controller
@RequestMapping("/mng/")
public class ExamMemberController {
	
	@Autowired
	ExamMemberService examMemberService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	/**
	 * 시험 대상자 관리 페이지 호출
	 */
	@RequestMapping(value={"examMember.do", "examResult.do"})
	public String initExamMemberMgt(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".initExamMemberMgt");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".initExamMemberMgt");
		
		String pathType;
		String url = request.getServletPath();
		String userType = session.getAttribute("userType") + "";
		// logger.info("url : " + url);
		
		if (url.equals("/mng/examMember.do")) {
			pathType = "EM";
		} else if (url.equals("/mng/examResult.do")) {
			pathType = "ER";
		} else {
			pathType = "Unknown";
		}
		model.addAttribute("pathType", pathType);
		model.addAttribute("userType", userType);
		logger.info("pathType : " + pathType);
		logger.info("userType : " + userType);
				
		return "/mng/examMember";
	}
	
	/**
	 * 시험 목록 호출
	 */
	@RequestMapping("listExam2.do")
	public String listExam2(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listExam2");
		logger.info("   - paramMap : " + paramMap);
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
		int pageIndex = (currentPage - 1) * pageSize;
						
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		String userType = session.getAttribute("userType") + "";
		String loginId = "";
		
		if (userType.equals("D")) {
			loginId  = session.getAttribute("loginId") + "";
		}
		
		paramMap.put("userType", userType);
		paramMap.put("loginID", loginId);
		
		logger.info("userType : " + userType + " loginID : " + loginId);
		
		// 시험 목록 조회
		List<Map<String, Object>> examListMap = examMemberService.listExam2(paramMap);
		model.addAttribute("examListMap", examListMap);
		
		// 조회된 총 시험 수 조회
		int totalCount = examMemberService.countListExam2(paramMap);
		model.addAttribute("examCnt", totalCount);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageExam", currentPage);
		
		logger.info("+ End " + className + ".listExam2");
		
		return "/mng/examMemberExamList";
	}
	
	/**
	 * 미출제 시험 유형 확인
	 */
	@RequestMapping("typeNullChk.do")
	@ResponseBody
	public Map<String, Object> typeNullChk(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".typeNullChk");
		logger.info("   - paramMap : " + paramMap);

		// 선택한 시험의 유형별 출제여부 조회
		Map<String, String> typeNullMap = examMemberService.typeNullChk(paramMap);
		
		String resultA = typeNullMap.get("isNullA");
		String resultB = typeNullMap.get("isNullB");
		String resultC = typeNullMap.get("isNullC");
		
		logger.info(":::typeNullChk.do:::");
		logger.info("resultA : " + resultA);
		logger.info("resultB : " + resultB);
		logger.info("resultC : " + resultC);
		logger.info("::::::::::::::::::::");
		
		Map<String, Object> returnMap = new HashMap();
		String resultMsg = "SUCCESS";
				
		if (resultA.equals("F") || resultB.equals("F") || resultC.equals("F")) {		// 시험 유형 중 하나라도 출제가 안 됐으면 FAIL
			resultMsg = "FAIL";
			returnMap.put("result", resultMsg);
		} else if (resultA.equals("T") && resultB.equals("T") && resultC.equals("T")) {	// 시험 유형이 전부 출제됐으면 SUCCESS
			returnMap.put("result", resultMsg);
		} else {
			resultMsg = "Unknown Error!!";
			returnMap.put("result", resultMsg);
		}
		returnMap.put("currentPage", paramMap.get("currentPage"));
		returnMap.put("classNo", paramMap.get("classNo"));
		
		logger.info("+ End " + className + ".typeNullChk");

		return returnMap;
	}
	
	
	/**
	 * 시험 응시자 목록 호출
	 */
	@RequestMapping("listExamMember.do")
	public String listExamMember(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".listExamMember");
		logger.info("   - paramMap : " + paramMap);
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage - 1) * pageSize;								// 페이지 시작 row 번호
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);

		// 선택한 시험의 응시자 수 조회
		int examMemCnt = examMemberService.countListExamMember(paramMap);
		
		// 선택한 시험의 응시자 목록 조회
		List<Map<String, Object>> examMemMap = examMemberService.listExamMember(paramMap);
		model.addAttribute("examMemMap", examMemMap);
		
		model.addAttribute("examMemCnt", examMemCnt);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageExamMember", currentPage);
		
		logger.info("+ End " + className + ".listExamMember");

		return "/mng/examMemberMemberList";
	}
}
