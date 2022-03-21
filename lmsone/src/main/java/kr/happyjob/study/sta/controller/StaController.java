package kr.happyjob.study.sta.controller;


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

import kr.happyjob.study.sta.model.StaModel;
import kr.happyjob.study.sta.model.StudentModel;
import kr.happyjob.study.sta.service.StaService;
import kr.happyjob.study.sta.service.StudentService;



@Controller
@RequestMapping("/sta/")
public class StaController {
	
	@Autowired
	StaService staService;
	
	@Autowired
	StudentService studentService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	/**
	 * 통계 만족도 화면 
	 */
	@RequestMapping("satisfaction.do")
	public String initComnCod(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		
		paramMap.put("currentPage", "1");
		logger.info("+ Start " + className + ".initComnCod");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".initComnCod");
		//int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		//int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		//int pageIndex = (currentPage-1)*pageSize;												// 페이지 시작 row 번호
		int currentPage = 1;		
		int pageSize = 5;
		
		paramMap.put("pageIndex", 1);
		paramMap.put("pageSize", pageSize);
		
		// 만족도 목록 조회
		List<StaModel> liststaModel = staService.liststa(paramMap);
		model.addAttribute("liststaModel", liststaModel);
		
		// 만족도 목록 카운트 조회
		int totalCount = staService.countList(paramMap);
		System.err.println(liststaModel);
		model.addAttribute("totalCnt", totalCount);
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPage",currentPage);
		return "sta/sta";
	}
	@RequestMapping("failNum.do")
	public String initComnCod2(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		
		paramMap.put("currentPage", "1");
		logger.info("+ Start " + className + ".initComnCod2");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".initComnCod2");
		//int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		//int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		//int pageIndex = (currentPage-1)*pageSize;												// 페이지 시작 row 번호
		int currentPage = 1;		
		int pageSize = 5;
		
		paramMap.put("pageIndex", 1);
		paramMap.put("pageSize", pageSize);
		
		// 만족도 목록 조회
		List<StaModel> liststaModel = staService.liststa(paramMap);
		model.addAttribute("liststaModel", liststaModel);
		
		// 만족도 목록 카운트 조회
		int totalCount = staService.countList(paramMap);
		System.err.println(liststaModel);
		model.addAttribute("totalCnt", totalCount);
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPage",currentPage);
		return "sta/fail";
	}
	//수강목록 조회
	@RequestMapping("studentNum.do")
	public String initComnCod3(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		

		logger.info("+ Start " + className + ".initComnCod3");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".initComnCod3");
		
		



		return "sta/student";
	}
	
	@RequestMapping("graph.do")
	@ResponseBody
	public Map<String, Object> graph(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".graph");
		logger.info("   - currentPage : " + paramMap);

		logger.info("paramMap : " + paramMap);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<Map<String, Object>> studentlist = studentService.studentlist(paramMap);  
				
		logger.info("studentlist : " + studentlist);

		resultMap.put("studentlist", studentlist);

		logger.info("resultMap : " + resultMap);
		
		/*int countlist = staService.selectTotalCnt(resultMap);*/
		
/*		List<StudentModel> student = studentService.student(paramMap);
		model.addAttribute("student", student);
*/
		
		/*resultMap.put("countlist",countlist);*/
		logger.info("+ End " + className + ".graph");
		return resultMap;
	}

	

	/*만족도 페이징처리*/
	@RequestMapping("paging.do")
	@ResponseBody
	public Map<String, Object> pageing( int currentPage
        	, 	int pageSize ,
        	@RequestParam(name = "class_startdate", defaultValue = "1000-01-01")  String class_startdate,
        	@RequestParam(name = "class_enddate", defaultValue = "3000-01-01")  String class_enddate ) throws Exception {
		logger.info("+ Start " + className + ".initComnCod");
		logger.info("   - currentPage : " + currentPage);
		logger.info("+ End " + className + ".initComnCod");
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		int pageIndex = (currentPage-1)*pageSize;									// 페이지 시작 row 번호	
		
		resultMap.put("currentPage", currentPage);
		resultMap.put("pageSize", pageSize);		
		resultMap.put("pageIndex", pageIndex);
		resultMap.put("class_startdate", class_startdate);
		resultMap.put("class_enddate", class_enddate);
		
		
		// 만족도 목록 조회
		List<StaModel> liststaModel = staService.selectSerchList(resultMap);
		
		int countlist = staService.selectTotalCnt(resultMap);

		
		resultMap.put("liststaModel",liststaModel);
		resultMap.put("countlist",countlist);
		return resultMap;
	}

	
	/*만족도 단건조회*/
	@RequestMapping("selectSatisfaction.do")
	@ResponseBody
	public Map<String, Object> selectsatisfaction (int class_no) throws Exception {
		
		logger.info("+ Start " + className + ".selectSatisfaction");
		logger.info("   - class_no : " + class_no);

		
		// 만족도 단건조회
		StaModel staModel = staService.selectsatisfaction(class_no);
		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("searchname", staModel.getName());
		resultMap.put("searchavgg", staModel.getAvgg());
		resultMap.put("searchmaxx", staModel.getMaxx());
		resultMap.put("searchminn", staModel.getMinn());
		resultMap.put("searchSubject", staModel.getSubject());
		
		logger.info("+ End " + className + ".selectsatisfaction");
		
		return resultMap;

	}
	/*수강인원 단건조회*/
/*	@RequestMapping("signUpList.do")
	@ResponseBody
	public Map<String, Object> signUpCount (int class_no) throws Exception {
		
		logger.info("+ Start " + className + ".signUpList");
		logger.info("   - class_no : " + class_no);

		*/
/*		// 수강인원 단건조회
		 StudentModel signUpCount = studentService.signUpCount(class_no);
		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();		
		resultMap.put("ccname", signUpCount.getCname());
		resultMap.put("ccno", signUpCount.getCno());
		resultMap.put("ccnt", signUpCount.getCnt());

		
		logger.info("+ End " + className + ".signUpList");
		
		return resultMap;
	
	}*/
	
	
	
	
}
