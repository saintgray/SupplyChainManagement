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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.common.comnUtils.ComnCodUtil;
import kr.happyjob.study.mng.service.ExamService;
import kr.happyjob.study.mng.model.ExamMgtModel;

@Controller
@RequestMapping("/mng/")
public class ExamController {
	
	@Autowired
	ExamService examService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	/**
	 * 시험 문제 관리 페이지 호출
	 */
	@RequestMapping("questionMgt.do")
	public String initExamMgt(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".initExamMgt");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".initExamMgt");

		return "/mng/questionMgt";
	}
	
	/**
	 * 강의 목록 호출
	 */
	@RequestMapping("listClass.do")
	public String listClass(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listClass");
		logger.info("   - paramMap : " + paramMap);
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
		int pageIndex = (currentPage - 1) * pageSize;
						
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		// 강의 목록 조회
		List<ExamMgtModel> listClassModel = examService.listClass(paramMap);
		model.addAttribute("listClassModel", listClassModel);
		
		// 조회된 총 강의 수 조회
		int totalCount = examService.countListClass(paramMap);
		model.addAttribute("classCnt", totalCount);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageClass", currentPage);
		
		logger.info("+ End " + className + ".listClass");
		
		return "/mng/questionMgtClassList";
	}
	
	/**
	 * 시험 문항 목록 호출
	 */
	@RequestMapping("listExam.do")
	public String listExam(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".listExam");
		logger.info("   - paramMap : " + paramMap);
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage - 1) * pageSize;								// 페이지 시작 row 번호
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		// 선택한 강의의 시험 목록 조회
		List<ExamMgtModel> listExamModel = examService.listExam(paramMap);
		model.addAttribute("listExamModel", listExamModel);
		
		// 선택한 강의의 시험 개수 조회
		Map<String, Object> cntMap = examService.countMapExam(paramMap);
		model.addAttribute("examCnt", cntMap.get("examCnt"));
		model.addAttribute("examMaxqNo", cntMap.get("examMaxqNo"));
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageExam", currentPage);
		
		logger.info("+ End " + className + ".listExam");

		return "/mng/questionMgtExamList";
	}

	/**
	 *  문항 상세 조회
	 */
	@RequestMapping("selectQuestion.do")
	@ResponseBody
	public Map<String, Object> selectQuestion(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectQuestion");
		logger.info("   - paramMap : " + paramMap);

		// 문항 상세 조회
		Map<String, Object> questionDtlMap = examService.selectQuestion(paramMap);
		
		logger.info("::::What's in questionDtlMap?::::");
		logger.info("exClassNo : " + questionDtlMap.get("exClassNo"));
		logger.info("qNo : " + questionDtlMap.get("qNo"));
		logger.info("qType : " + questionDtlMap.get("qType"));
		logger.info("qContent : " + questionDtlMap.get("qContent"));
		logger.info("qOne : " + questionDtlMap.get("qOne"));
		logger.info("qTwo : " + questionDtlMap.get("qTwo"));
		logger.info("qThree : " + questionDtlMap.get("qThree"));
		logger.info("qFour : " + questionDtlMap.get("qFour"));
		logger.info("qSolution : " + questionDtlMap.get("qSolution"));
		logger.info("::::::::::::::::::::::::::::::::::");
		
		String chkResult = questionDtlMap.get("qContent") + "";
		String resultMsg = "조회 성공 ㄴ^ㅁ^ㄱ";
		
		if (chkResult == null || chkResult.equals("")) {
			questionDtlMap.put("result", "FAIL");
			resultMsg = "조회 실패 ㅠㅁㅠ";
		} else {
			questionDtlMap.put("result", "SUCCESS");
		}
		questionDtlMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".selectQuestion");
		
		return questionDtlMap;
	}
	
	/**
	 *  응시자 수 조회
	 */
	@RequestMapping("chkMemberCnt.do")
	@ResponseBody
	public Map<String, Object> chkMemberCnt(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".chkMemberCnt");
		logger.info("   - paramMap : " + paramMap);

		// 응시자 수 조회
		Map<String, Object> memberCntMap = examService.chkMemberCnt(paramMap);
		memberCntMap.put("classNo", paramMap.get("classNo"));
		memberCntMap.put("action", paramMap.get("chkLoc"));
		
		if (!(paramMap.get("qNo") + "").equals("noVal")) {
			memberCntMap.put("qNo", paramMap.get("qNo"));
		}
		if (!(paramMap.get("qType") + "").equals("noVal")) {
			memberCntMap.put("qType", paramMap.get("qType"));
		}
		
		logger.info("   - memberCntMap : " + memberCntMap);
		logger.info("+ End " + className + ".chkMemberCnt");
		
		return memberCntMap;
	}
	
	/**
	 *  문항 저장
	 */
	@RequestMapping("saveQuestion.do")
	@ResponseBody
	public Map<String, Object> saveQuestion(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".saveQuestion");
		logger.info("   - paramMap : " + paramMap);

		String action = (String)paramMap.get("action");
		String result = "INSERT";
		String resultMsg = "새 문항이 등록되었습니다. ㄴ^0^ㄱ";
		
		if ("I".equals(action)) {
			// 문항 INSERT
			examService.insertQuestion(paramMap);
		} else if("U".equals(action)) {
			// 문항 UPDATE
			examService.updateQuestion(paramMap);
			result = "UPDATE";
			resultMsg = "문항이 수정되었습니다. ^_^";
		} else {
			result = "FALSE";
			resultMsg = "알 수 없는 요청입니다. T^T";
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".saveQuestion");
		
		return resultMap;
	}
	
	/**
	 *  문항 관리 폼 문제 번호 중복 검사
	 */
	@RequestMapping("qNoDuplicationChk.do")
	@ResponseBody
	public int qNoDuplicationChk(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".qNoDuplicationChk");
		logger.info("   - paramMap : " + paramMap);
		
		int chkQno = examService.qNoCheck(paramMap);
		
		logger.info("   - chkQno : " + chkQno);
		
		logger.info("+ End " + className + ".qNoDuplicationChk");
		
		return chkQno;
	}
	
	/**
	 *  문항 삭제 DELETE
	 */
	@RequestMapping("deleteQuestion.do")
	@ResponseBody
	public Map<String, Object> deleteQuestion(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".deleteQuestion");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "삭제되었습니다.";

		examService.deleteQuestion(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".deleteQuestion");
		
		return resultMap;
	}
}
