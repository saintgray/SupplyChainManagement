package kr.happyjob.study.sup.controller;

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

import kr.happyjob.study.sup.service.ClassPlanService;

@Controller
@RequestMapping("/sup/")
public class ClassPlanController {
	
	@Autowired
	ClassPlanService classPlanService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	

	@RequestMapping("classPlan.do")
	public String initClassPlan(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".initClassPlan");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".initClassPlan");

		return "sup/classPlan";
	}
	
	/*강사계획서목록*/
	@RequestMapping("listClassPlan.do")
	public String listClassPlan(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listClassPlan");
		logger.info("   - paramMap : " + paramMap);
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;												// 페이지 시작 row 번호
		
		paramMap.put("userType", (String)session.getAttribute("userType"));		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		paramMap.put("loginId", (String)session.getAttribute("loginId")); //로그인 아이디
		
		
		
		
		
		// 강의계획서 목록 조회
		List<Map<String,Object>> listClassPlanModel = classPlanService.selectClassPlanList(paramMap);
		model.addAttribute("listClassPlanModel", listClassPlanModel);
		
		// 강의계획서 목록 카운트 조회
		int totalCount = classPlanService.countClassPlan(paramMap);
		model.addAttribute("totalCntClassPlan", totalCount);
		
		model.addAttribute("pageSizeClassPlan", pageSize);
		model.addAttribute("currentPageClassPlan",currentPage);
		
		logger.info("+ End " + className + ".listClassPlan");
		

		return "/sup/classPlanList";
	}	
	
	
	/*해당 기간에 강의 없는 강의 list와 강의실 list 출력*/
	@RequestMapping("selectListRegsiterClassPlan")
	@ResponseBody
	public Map<String, Object> selectListRegsiterClassPlan(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
	
		logger.info("+ Start " + className + ".selectListRegsiterClassPlan");
		logger.info("   - paramMap : " + paramMap);
		
		
		Map<String, Object> resultMap = new HashMap<>();
		
		List<Map<String,Object>> listTeacher = classPlanService.selectListTeacher(paramMap);
		List<Map<String,Object>> listClassRoom = classPlanService.selectListClassRoom(paramMap);
		resultMap.put("listTeacher", listTeacher);
		resultMap.put("listClassRoom", listClassRoom);
		
		logger.info("+ End " + className + ".selectListRegsiterClassPlan");
		
		return resultMap;
	}
	
	
	/*강의계획서 등록*/
	@RequestMapping("registerClassPlan.do")
	@ResponseBody
	public Map<String, Object> registerClassPlan(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".registerClassPlan");
		logger.info("   - paramMap : " + paramMap);
		String result = "SUCCESS";
		String resultMsg = "";
		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		
		String action = (String)paramMap.get("action");
		
	
		
		if("I".equals(action)) {
			classPlanService.registerClassPlan(paramMap);
		
		}
		else if("U".equals(action)) {
		
			classPlanService.updateClassPlan(paramMap);
		}
		


		logger.info("+ End " + className + ".registerClassPlan");

		return resultMap;
	}
	
	/*삭제*/
	@RequestMapping("deleteClassPlan.do")
	@ResponseBody
	public Map<String, Object> deleteClassPlan(Model model, @RequestParam(value="delList[]") List<String> paramList, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".deleteClassPlan");
		logger.info("   - paramMap : " + paramList);
		
		//0:성공
		//1:실패
		Map<String, Object> resultMap = new HashMap<>();


		//강의 계획서 삭제 delete_yn 컬럼 y로 변경
		classPlanService.deleteClassPlan(paramList);
		logger.info("+ End " + className + ".deleteTeacher");
		
		return resultMap;
	}
	
	@RequestMapping("classPlanDtlInfo.do")
	@ResponseBody
	public Map<String, Object> classPlanDtlInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".classPlanDtlInfo");
		logger.info("   - ParamMap : " + paramMap);

		// 강의계획서 정보

		Map<String, Object> classPlanInfo = classPlanService.classPlanDtlInfo(paramMap);

		Map<String, Object> resultMap =  new HashMap<String, Object>();

		resultMap.put("classPlanInfo", classPlanInfo);
		
		logger.info("+ End " + className + ".classPlanDtlInfo");
		return resultMap;
	}
}