package kr.happyjob.study.sup.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.sup.service.ReferenceService;

@Controller
@RequestMapping("/sup/")
public class ReferenceController {
	
	@Autowired
	ReferenceService referenceService;
	
	
	@Value("${fileUpload.rootPath}")
	private String rootPath;

	@Value("${fileUpload.reference}")
	private String reference;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	

	@RequestMapping("referenceMgt.do")
	public String initReferenceMgt(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".initReference");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".initReference");

		return "sup/reference";
	}
	
	@RequestMapping("reference.do")
	public String initReference(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".initReference");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".initReference");

		return "sup/reference";
	}
	
	/*학습자료 목록*/
	@RequestMapping("listReference.do")
	public String listClassPlan(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listReference");
		logger.info("   - paramMap : " + paramMap);
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;												// 페이지 시작 row 번호
		
		paramMap.put("userType", (String)session.getAttribute("userType"));		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		paramMap.put("loginId", (String)session.getAttribute("loginId")); //로그인 아이디
		
		
		
		
		
		// 학습자료 목록 조회
		List<Map<String,Object>> listReferenceModel = referenceService.selectReferenceList(paramMap);
		model.addAttribute("listReferenceModel", listReferenceModel);
		
		// 학습자료 목록 카운트 조회
		int totalCount = referenceService.countReferenceList(paramMap);
		model.addAttribute("totalCntReference", totalCount);
			                
		model.addAttribute("pageSizeReference", pageSize);
		model.addAttribute("currentPageReference",currentPage);
		
		logger.info("+ End " + className + ".listReference");
		

		return "/sup/referenceList";
	}	
	
	


	/*학습자료 등록*/
	@RequestMapping("registerReference.do")
	@ResponseBody
	public Map<String, Object> registerReference(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".registerReference");
		logger.info("   - paramMap : " + paramMap);
		String result = "SUCCESS";
		String resultMsg = "";
		paramMap.put("loginId", (String)session.getAttribute("loginId")); 
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		
		String action = (String)paramMap.get("action");
		
	
		
		if("I".equals(action)) {
			referenceService.registerReferenceBoardFile(paramMap, request);
			referenceService.registerReferenceBoardContent(paramMap);
		}
		else if("U".equals(action)) {
			/*파일 삭제후 다시 insert*/
			referenceService.deleteReferenceBoardFile(paramMap, request);
			referenceService.updateReferenceBoardContent(paramMap);  
			
		}
		
		/*update not file*/
		else if("UNF".equals(action)) {
			referenceService.updateReferenceBoardContent(paramMap);  
		}


		logger.info("+ End " + className + ".registerReference");

		return resultMap;
	}
	/*학습자료 다운로드*/
	@RequestMapping("referenceDownloadFile.do")
	public void downloadFile(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".referenceDownloadFile");
		logger.info("   - paramMap : " + paramMap);

		// 첨부파일
		Map<String, Object> list = referenceService.selectDownloadFile(paramMap);
		logger.info("------------------->" + list);

		byte fileByte[] = FileUtils.readFileToByteArray(new File( (String) list.get("file_root"))); // file full path

		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode((String) list.get("file_name"), "UTF-8") + "\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.getOutputStream().write(fileByte);

		response.getOutputStream().flush();
		response.getOutputStream().close();

		logger.info("+ End " + className + ".referenceDownloadFile");

	}
	/*학습자료 한건조회*/
	@RequestMapping("referenceDtlInfo.do")
	@ResponseBody
	public Map<String, Object> referenceDtlInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".classPlanDtlInfo");
		logger.info("   - ParamMap : " + paramMap);

		// 개발자 정보

		Map<String, Object> referenceInfo = referenceService.referenceDtlInfo(paramMap);

		Map<String, Object> resultMap =  new HashMap<String, Object>();

		resultMap.put("referenceInfo", referenceInfo);
		
		logger.info("+ End " + className + ".referenceDtlInfo");
		return resultMap;
	}
	/*학습자료 삭제*/
	@RequestMapping("deleteReference.do")
	@ResponseBody
	public Map<String, Object> deleteReference(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".deleteReference");
		logger.info("   - paramMap : " + paramMap);
		
		//0:성공
		//1:실패
		Map<String, Object> resultMap = new HashMap<>();

		referenceService.deleteReference(paramMap, request);
		logger.info("+ End " + className + ".deleteReference");
		
		return resultMap;
	}

}