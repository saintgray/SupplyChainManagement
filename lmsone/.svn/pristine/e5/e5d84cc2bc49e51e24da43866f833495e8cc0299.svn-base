package kr.happyjob.study.mng.controller;

import java.util.*;

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
import kr.happyjob.study.mng.service.TakeExamService;

@Controller
@RequestMapping("/mng/")
public class TakeExamController {
	
	@Autowired
	TakeExamService takeExamService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	/**
	 * 시험 응시 페이지 호출
	 */
	@RequestMapping("exam.do")
	public String initTakeExam(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".initTakeExam");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".initTakeExam");

		return "/mng/takeExam";
	}
	
	/**
	 * 시험 목록 호출
	 */
	@RequestMapping("listTexam.do")
	public String listTexam(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listTexam");
		logger.info("   - paramMap : " + paramMap);
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
		int pageIndex = (currentPage - 1) * pageSize;
		
		paramMap.put("loginID", session.getAttribute("loginId"));
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		// 시험 목록 조회
		List<Map<String, Object>> listTexamMap = takeExamService.listTexam(paramMap);
		model.addAttribute("listTexamMap", listTexamMap);
		
		// 조회된 총 시험 수 조회
		int totalCount = takeExamService.countListTexam(paramMap);
		model.addAttribute("texamCnt", totalCount);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageTexam", currentPage);
		
		logger.info("+ End " + className + ".listTexam");
		
		return "/mng/takeExamList";
	}
	
	/**
	 * 응시했는지 확인
	 */
	@RequestMapping("takeExamChk.do")
	@ResponseBody
	public Map<String, Object> takeExamChk(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".takeExamChk");
		logger.info("   - paramMap : " + paramMap);
		
		paramMap.put("loginID", session.getAttribute("loginId"));

		// 문항 작성 수 확인
		int inputAnswerCnt = takeExamService.takeExamChk(paramMap);
		
		logger.info("inputAnswerCnt : " + inputAnswerCnt);
		
		Map<String, Object> chkTakeMap = new HashMap();
		
		boolean isTake = true;
		
		if (inputAnswerCnt > 0) {
			logger.info("응시자임!!");
		} else if (inputAnswerCnt == 0) {
			logger.info("응시자 아님!!");
			isTake = false;
		} else {
			logger.info("알 수 없음");
		}
		
		chkTakeMap.put("isTake", isTake);
		chkTakeMap.put("classNo", paramMap.get("classNo"));
		
		logger.info("+ End " + className + ".takeExamChk");
		
		return chkTakeMap;
	}
	
	/**
	 * 시험 응시 팝업 호출
	 */
	@RequestMapping("takeExamForm.do")
	public String callExamPopup(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".callExamPopup");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".callExamPopup");

		return "/mng/takeExamForm";
	}
	
	/**
	 * 응시 시작 후 문제 유형 및 정보들 뽑아 오기
	 */
	@RequestMapping("initQuestionInfo.do")
	@ResponseBody
	public Map<String, Object> initQuestionInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".initQuestionInfo");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> questionListMap = new HashMap();
		
		// 문제 유형 Random 배열 설정
		String[] arrType = new String[3];
		arrType[0] = "A";
		arrType[1] = "B";
		arrType[2] = "C";
		
		int minIdx = 0;
		int maxIdx = 3;
		int typeIdx = (int)((Math.random() * (maxIdx - minIdx)) + minIdx);
				
		String examType = arrType[typeIdx];
				
		paramMap.put("examType", examType);
		paramMap.put("loginID", session.getAttribute("loginId"));
		Map<String, String> examInfoMap = takeExamService.takeExamGetInfo(paramMap); 
		
		questionListMap.put("classNo", paramMap.get("classNo"));
		questionListMap.put("examType", examType);
		questionListMap.put("userName", examInfoMap.get("userName"));			// loginID에 해당하는 회원 이름 가져오기
		questionListMap.put("className", examInfoMap.get("className"));			// classNo에 해당하는 과정명 가져오기
		questionListMap.put("questionCnt", examInfoMap.get("questionCnt"));		// 문항 수 가져오기
		
		logger.info("   - typeIdx : " + typeIdx);
		logger.info("   - examType : " + examType);
		logger.info("   - userName : " + examInfoMap.get("userName"));
		logger.info("   - className : " + examInfoMap.get("className"));
			
		// 문제 가져오기
		// Map<String, String> questionList = takeExamService.takeExamGetInfo(paramMap); 
		
		logger.info("+ End " + className + ".initQuestionInfo");
		
		return questionListMap;
	}
	
	/**
	 * 시험 문항 호출
	 */
	@RequestMapping("callQuestionList.do")
	public String callQuestionList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".callQuestionList");
		logger.info("   - paramMap : " + paramMap);
		
		// 시험 문항 조회
		List<Map<String, Object>> qListMap = takeExamService.callQuestionList(paramMap);
		model.addAttribute("qListMap", qListMap);
		
		// 시험 문항 수 조회
		int qlistCnt = takeExamService.callQuestionListCnt(paramMap);
		model.addAttribute("qlistCnt", qlistCnt);
		
		logger.info("+ End " + className + ".callQuestionList");
		
		return "/mng/takeExamFormList";
	}
	
	/**
	 * 답안 제출
	 */
	@RequestMapping("submitExam.do")
	@ResponseBody
	public Map<String, Object> submitExam(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".submitExam");
		logger.info("   - paramMap : " + paramMap);
		
		/* 시험을 그냥 종료했을 시 오답 처리를 위한 부분 START */
		String tmpQno = paramMap.get("qNo") + "";
		
		if (tmpQno.equals("NO")) {
			tmpQno = takeExamService.selectQno(paramMap);	// qNo를 순서대로 출력
			paramMap.put("qNo", tmpQno);
		}
		/* 시험을 그냥 종료했을 시 오답 처리를 위한 부분 END */
				
		// 채점 및 답안 INSERT를 위해 문자열을 쪼개서 배열화
		String[] arrQno = String.valueOf(paramMap.get("qNo")).split(",");	
		String[] arrAnswer = String.valueOf(paramMap.get("answer")).split(",");
		
		/* 시험 채점 후 UPDATE START */
		double examResult = 0.0; 										// 총점을 계산할 변수 선언
		int rightCnt = 0; 												// 정답 개수
		int qlistCnt = Integer.parseInt(paramMap.get("qlistCnt") + "");	// 문항 개수
		double iScore = 100.0 / qlistCnt; 								// 문제당 점수
		
		String solGroup = takeExamService.solGroup(paramMap);	// DB에서 정답 가져오기

		String[] arrSol = solGroup.split(",");
		// DB에서 가져온 답안의 GROUP_CONCAT 결과를 solMap에서 꺼낸 후 Object에서 String으로 형변환
		
		// for문으로 배열 값을 비교하며 채점
		for (int i = 0; i < arrSol.length; i++) {	
			if (arrSol[i].equals(arrAnswer[i])) {
				rightCnt++;
			}
		}
		
		examResult = Double.valueOf(String.format("%.2f", (rightCnt * iScore))); // 점수 계산
		logger.info("examResult : " + examResult + "\nrightCnt : " + rightCnt);
		
		paramMap.put("loginID", session.getAttribute("loginId"));
		paramMap.put("score", examResult);
		
		int markResult = takeExamService.updateScore(paramMap);	// DB에 학생 점수 UPDATE
		
		logger.info("markResult : " + markResult);
		
		/* 시험 채점 후 UPDATE END */
	
		Map<String, Object> answerMap;
		List<Map<String, Object>> answerMapList = new ArrayList<Map<String, Object>>();		
		
		for (int i = 0; i < arrQno.length; i++) {
			answerMap = new HashMap<String, Object>();
			
			answerMap.put("qNo", arrQno[i]);
			answerMap.put("answer", arrAnswer[i]);
			
			answerMapList.add(answerMap);
	
		}
		
		paramMap.put("answerMapList", answerMapList);
		
		int result = takeExamService.submitExam(paramMap);
		
		logger.info("   - result : " + result);
		logger.info("+ End " + className + ".submitExam");
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("resultCnt", result);
		resultMap.put("score", examResult);
		
		return resultMap;
	}
}
