package kr.happyjob.study.tmg.controller;

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

import kr.happyjob.study.tmg.service.TeacherListService;

@Controller
@RequestMapping("/tmg/")
public class TeacherListController {
	
	@Autowired
	TeacherListService teacherListService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@RequestMapping("teacherMgt.do")
	public String initTeacherMgt(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".initTeacherMgt");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".initTeacherMgt");

		return "tmg/teacherMG";
	}
	
	/*강사목록*/
	@RequestMapping("listTeacher.do")
	public String listTeahcer(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listTeahcer");
		logger.info("   - paramMap : " + paramMap);
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;												// 페이지 시작 row 번호
		
		paramMap.put("userType", (String)session.getAttribute("userType"));		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		paramMap.put("loginId", (String)session.getAttribute("loginId")); //로그인 아이디
		
		// 강사 목록 조회
		List<Map<String,Object>> listTeacherModel = teacherListService.selectTeacherList(paramMap);
		model.addAttribute("listTeacherModel", listTeacherModel);
		
		// 강사 목록 카운트 조회
		int totalCount = teacherListService.countTeacher(paramMap);
		model.addAttribute("totalCntTeacher", totalCount);
		
		model.addAttribute("pageSizeTeacher", pageSize);
		model.addAttribute("currentPageTeacher",currentPage);
		
		logger.info("+ End " + className + ".listTeahcer");
		

		return "/tmg/teacherList";
	}	
	/*강사 한건 조회*/
	@RequestMapping("teacherDtlInfo.do")
	@ResponseBody
	public Map<String, Object> teacherDtlInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".teacherDtlInfo");
		logger.info("   - ParamMap : " + paramMap);

		// 강사 정보

		Map<String, Object> teacherInfo = teacherListService.teacherDtlInfo(paramMap);

		Map<String, Object> resultMap =  new HashMap<String, Object>();

		resultMap.put("teacherInfo", teacherInfo);
		
		logger.info("+ End " + className + ".teacherDtlInfo");
		return resultMap;
	}
	

	
}
