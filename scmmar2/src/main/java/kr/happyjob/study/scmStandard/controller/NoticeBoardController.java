package kr.happyjob.study.scmStandard.controller;

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

import kr.happyjob.study.login.model.UserInfo;
import kr.happyjob.study.scm.model.FileModel;
import kr.happyjob.study.scmStandard.model.NoticeBoardModel;
import kr.happyjob.study.scmStandard.model.ProductModel;
import kr.happyjob.study.scmStandard.service.NoticeBoardService;

@Controller
@RequestMapping("/scmStandard/")
public class NoticeBoardController {
	
	@Autowired
	NoticeBoardService noticeBoardService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	// 파일 rootPath
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	// 공지사항 초기 화면
	@RequestMapping("noticeMgr.do")
	public String initComnCod(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".initnoticeInfo");
		logger.info("+ End " + className + ".initnoticeInfod");

		return "scmStandard/noticeBoardInfo";
	}
	
	
	// 공지사항 목록
	@RequestMapping("noticeBoardlist.do")
	public String noticeBoardlist(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {
		
		logger.info("+ Start " + className + ".noticeBoardlist");
		logger.info("   - paramMap : " + paramMap);
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;									// 페이지 시작 row 번호
				
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		// 공지사항 목록 조회
		List<NoticeBoardModel> noticeBoardlist = noticeBoardService.noticeBoardlist(paramMap);
		model.addAttribute("noticeBoardlist", noticeBoardlist);
		
		// 공지사항 목록 카운트 조회
		int totalCount = noticeBoardService.countListNoticeCod(paramMap);
		model.addAttribute("totalNoticeCod", totalCount);
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageNTCCod",currentPage);
		
		logger.info("+ End " + className + ".noticeBoardlist");

		return "/scmStandard/noticeBoardlist";
	}	

	
	// 공지사항 단건 조회
	@RequestMapping("selectNoticeCod.do")
	@ResponseBody
	public Map<String, Object> selectProductCod(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {
		
		logger.info("+ Start " + className + ".selectNoticeCod");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";
		
		// 공지사항 조회수
		int ntc_readcnt = noticeBoardService.updateNoticeCnt(paramMap);
		paramMap.put("ntc_readcnt", ntc_readcnt);
		
		// 공지사항 단건 조회
		NoticeBoardModel noticeBoardModel = noticeBoardService.selectNoticeCod(paramMap);
		
		if (noticeBoardModel != null) {
			result = "SUCCESS";
		} else {
			result = "단건 조회 실패";
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("noticeBoardModel", noticeBoardModel);
		
		logger.info("+ End " + className + ".selectNoticeCod");
		
		return resultMap;
	}
	
	
	// 공지사항 신규 등록
	@RequestMapping("saveNoticeCod.do")
	@ResponseBody
	public Map<String, Object> saveNoticeCod(@RequestParam Map<String, Object> paramMap, HttpSession session, HttpServletRequest request) throws Exception {
		
		logger.info("+ Start " + className + ".saveNoticeCod");
	    logger.info("   - paramMap : " + paramMap);
	    
	    String action = (String) paramMap.get("action");
		String result = "N";
		String resultMsg = "데이터  저장 시 오류가 발생했습니다."; 
		
		try {
	         if("I".equals(action)) {
	        	 noticeBoardService.insertNoticecode(paramMap, request);
	             resultMsg = "데이터가 저장되었습니다.";
	         }
	         else if ("U".equals(action)) {
	        	 noticeBoardService.updateNoticecode(paramMap, request);
	 		 	 resultMsg = "데이터 수정 완료.";
	         }
	         
	         result = "Y";
		} catch(Exception e) {
	         
	      }
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".saveNoticeCod");
		
		return resultMap;
		
	}
	
	
	// 파일 다운로드
	@RequestMapping("fileDown.do")
	public void downloadBbsAtmtFil(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
	
		logger.info("+ Start " + className + ".downloadBbsAtmtFil");
		logger.info("   - paramMap : " + paramMap);
		
		// 첨부파일 조회
		NoticeBoardModel selectFile = noticeBoardService.selectFile(paramMap);
		
		byte fileByte[] = FileUtils.readFileToByteArray(new File(selectFile.getFile_new_name()));

		response.setContentType("application/octet-stream");
	    response.setContentLength(fileByte.length);
	    response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(selectFile.getFile_ofname(),"UTF-8")+"\";");
	    response.setHeader("Content-Transfer-Encoding", "binary");
	    response.getOutputStream().write(fileByte);
	     
	    response.getOutputStream().flush();
	    response.getOutputStream().close();

		logger.info("+ End " + className + ".fileDown");
	}

	
	// 공지사항 삭제
	@RequestMapping("deleteNoticeCod.do")
	@ResponseBody
	public Map<String, Object> deleteProductCod(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {
		
		logger.info("+ Start " + className + ".deleteNoticeCod");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "삭제 되었습니다.";
		
		// 공지사항 삭제
		noticeBoardService.deleteNoticeCod(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".deleteNoticeCod");
		
		return resultMap;
	}

}
