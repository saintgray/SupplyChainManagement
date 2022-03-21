package kr.happyjob.study.mng.controller;

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
import org.springframework.web.bind.annotation.SessionAttribute;

import kr.happyjob.study.mng.service.MngService;


@Controller
@RequestMapping("/mng/")
public class MngController {
	
	@Autowired
	MngService mngService;
	
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	/* ------------------------ 학생 설문조사 부분 --------------------------	*/
	
	@RequestMapping("survey.do")
	public String lectureFeedback(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		
		logger.info("+ Start " + className + ".lectureFeedback");
		logger.info("   - paramMap : " + paramMap);

		logger.info("+ end " + className + ".lectureFeedback");

		return "mng/surveyMain";
	}

	/* 설문조사 목록조회 */
	@RequestMapping("surveyList.do")
	public String surveyList(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {

		logger.info("+ Start " + className + ".surveyList");
		logger.info("+ paramMap " + paramMap + "paramMap");
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;														// 페이지 시작 row 번호
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		int listCount = mngService.surveyListCnt(paramMap);

		List<Map<String, Object>> surveyList = mngService.surveyListSelect(paramMap);

		logger.info("+++++surveyList : " + surveyList);
		logger.info("+++++listCount : " + listCount);
		
		model.addAttribute("surveyList", surveyList);
		model.addAttribute("listCount", listCount);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPage",currentPage);
		
		return "mng/surveyList";
	}
	
	/* 설문조사 상세조회 */
	@RequestMapping("survey_do.do")
	@ResponseBody
	public Map<String, Object> survey_do(Model model, @RequestParam Map<String, Object> paramMap, int appraisal_no, HttpSession session) throws Exception {

		session.setAttribute("appraisal_no", appraisal_no);
		
		logger.info("+ Start " + className + ".survey_do");
		logger.info("+ paramMap " + paramMap + "paramMap");		
		logger.info("+ appraisal_no : " + appraisal_no);
		
		Map<String, Object> surveyInfo = mngService.surveySelectDetail(appraisal_no);
		logger.info("+ surveyInfo" + surveyInfo);
		
		Map<String, Object> resultMap = new HashMap<>();
		
		String result = "SUCCESS";
		String resultMsg = "조회 성공";
		
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("surveyInfo", surveyInfo);
				
		return resultMap;
	}
	
	/* 설문조사 수정 */
	@RequestMapping("surveyUpdate.do")
	@ResponseBody
	public Map<String, Object> surveyUpdate(Model model, @RequestParam Map<String, Object> paramMap, HttpSession session) throws Exception {

		
		logger.info("+ Start " + className + ".surveyUpdate");
		logger.info("+ paramMap " + paramMap + "paramMap");	
		
		mngService.surveyUpdate(paramMap);
				
		Map<String, Object> resultMap = new HashMap<>();
		
		String result = "SUCCESS";
		String resultMsg = "조회 성공";
		
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
				
		return resultMap;
	}
	

	/* ------------------------ 강사 설문조사 결과확인 부분 --------------------------	*/
	
	@RequestMapping("consultMgt.do")
	public String apResult(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		String id = (String) session.getAttribute("loginId");
		System.out.println("id: " + id);
		session.setAttribute("id", id);
		
		logger.info("+ Start " + className + ".consultMgt");
		logger.info("   - paramMap : " + paramMap);
		logger.info("+ end " + className + ".consultMgt");
		
		List<String> search_combo = mngService.search_combo(id);
		
		model.addAttribute("search_combo", search_combo);
		logger.info("   - search_combo : " + search_combo);

		return "mng/apResultMain";
	}
	
	/* 설문조사 목록조회 */
	@RequestMapping("apResultList.do")
	public String apResultList(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {

		logger.info("+ Start " + className + ".apResultList");
		logger.info("+ paramMap " + paramMap + "paramMap");
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;									// 페이지 시작 row 번호
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		

		logger.info("+ paramMap " + paramMap + "paramMap");
		
		int listCount = mngService.ResultCnt(paramMap);

		List<Map<String, Object>> resultlist = mngService.apResultListSelect(paramMap);
		
		logger.info("+++++resultlist : " + resultlist);
		logger.info("+++++listCount : " + listCount);
		
		model.addAttribute("resultlist", resultlist);
		model.addAttribute("listCount", listCount);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPage",currentPage);
		
		return "mng/apResultList";
	}
	
	/* 하위리스트 목록조회 */
	@RequestMapping("apListDtl.do")
	public String apListDtl(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {

		logger.info("+ Start " + className + ".apListDtl");
		logger.info("+ paramMap " + paramMap + "paramMap");
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;									// 페이지 시작 row 번호
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		

		logger.info("+ paramMap " + paramMap + "paramMap");
		
		int listCount2 = mngService.DtlResultCnt(paramMap);

		List<Map<String, Object>> resultlistdtl = mngService.apListDtl(paramMap);
		
		logger.info("+++++resultlistdtl : " + resultlistdtl);
		logger.info("+++++listCount2 : " + listCount2);
		
		model.addAttribute("resultlistdtl", resultlistdtl);
		model.addAttribute("listCount2", listCount2);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPage",currentPage);
		
		return "mng/apResultListDtl";
	}
		
	@RequestMapping("survey_insert.do")
	   @ResponseBody
	   public Map<String, Object> survey_insert(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception{
		   logger.info("+ Start " + className + ".survey_insert");
		   logger.info("   - paramMap : " + paramMap);
		   
		   String result = "SUCCESS";
		   
		   List<Map<String, Object>> survey_endclass = mngService.survey_endclass(paramMap);
		   		   
		   logger.info("++ survey_endclass : " + survey_endclass);
		
		   Map<String, Object> resultMap = new HashMap<String, Object>();
		   
		   if(survey_endclass.size() > 0){			   
			   
			   for(int i = 0; i < survey_endclass.size(); i++){
				   Map<String, Object> endmap = new HashMap<String, Object>(survey_endclass.get(i));
				   endmap.put("s_loginID", paramMap.get("s_loginID"));
				   mngService.survey_insert(endmap);
			   }
			   resultMap.put("result", result);
		   } else {
			   
			   result = "ALREADY";
			   resultMap.put("result", result);
			   
		   }
		   
		   logger.info("+ End " + className + ".survey_insert");
		   logger.info("+ resultMap " + resultMap );
		   
		   return resultMap;
	   }
	
	
}
