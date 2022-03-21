package kr.happyjob.study.lec.controller;

import java.util.ArrayList;
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

import kr.happyjob.study.lec.service.LectureFeedbackService;
import kr.happyjob.study.system.model.UserMgmtModel;

@Controller
@RequestMapping("/lec/")
public class LectureFeedbackController {
	
	@Autowired
	LectureFeedbackService lectureFeedbackService;
	
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@RequestMapping("lectureFeedback.do")
	public String lectureFeedback(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		
		logger.info("+ Start " + className + ".lectureFeedback");
		logger.info("   - paramMap : " + paramMap);

		logger.info("+ end " + className + ".lectureFeedback");

		return "lec/lectureFeedback";
	}

	/* 강의피드백 목록조회 */
	@RequestMapping("feedbackList.do")
	public String feedbackList(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {

		logger.info("+ Start " + className + ".feedbackList");
		logger.info("+ paramMap " + paramMap + "paramMap");
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;														// 페이지 시작 row 번호
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		int listCount = lectureFeedbackService.feedbackListCnt(paramMap);

		List<Map<String, Object>> feedbackList = lectureFeedbackService.feedbackListSelect(paramMap);

		logger.info("+++++feedbackList : " + feedbackList);
		logger.info("+++++listCount : " + listCount);
		
		model.addAttribute("feedbackList", feedbackList);
		model.addAttribute("listCount", listCount);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPage",currentPage);
		
		return "lec/feedbackList";
	}
	
	/* 강의피드백 상세조회 */
	@RequestMapping("FBselectDetail.do")
	@ResponseBody
	public Map<String, Object> FBselectDetail(Model model, @RequestParam Map<String, Object> paramMap, int appraisal_no, HttpSession session) throws Exception {

		session.setAttribute("appraisal_no", appraisal_no);
		
		logger.info("+ Start " + className + ".FBselectDetail");
		logger.info("+ paramMap " + paramMap + "paramMap");		
		logger.info("+ appraisal_no : " + appraisal_no);
		
		Map<String, Object> surveyInfo = lectureFeedbackService.FBselectDetail(appraisal_no);
		logger.info("+ surveyInfo" + surveyInfo);
		
		Map<String, Object> resultMap = new HashMap<>();
		
		String result = "SUCCESS";
		String resultMsg = "조회 성공";
		
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("surveyInfo", surveyInfo);
				
		return resultMap;
	}
	
	/* 강의피드백 삭제 */
	@RequestMapping("FBdelete.do")
	@ResponseBody
	public Map<String, Object> FBdelete(Model model, @RequestParam("appraisal_no") int appraisal_no, HttpSession session) throws Exception {

		Map<String, Object> resultMap = new HashMap<>();
		
		int delOk = lectureFeedbackService.FBdelete(appraisal_no);
		System.out.println("++delOk : " + delOk);	
		
		String result = "SUCCESS";
		String resultMsg = "삭제 성공";
		
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		return resultMap;
	}
	
}
