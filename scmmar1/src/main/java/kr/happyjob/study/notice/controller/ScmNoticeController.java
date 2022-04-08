package kr.happyjob.study.notice.controller;
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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.common.comnUtils.NewFileUtil;

import kr.happyjob.study.notice.model.NoticeModel;
import kr.happyjob.study.notice.service.ScmNoticeService;
import kr.happyjob.study.scm.model.FileModel;


@Controller
@RequestMapping("/scm/")
public class ScmNoticeController {

	@Autowired
	ScmNoticeService noticeService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	private final static String rootPath = "c://notice/";
	
	
	@RequestMapping("noticeMgr.do")
	public String initNotice(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".initNotice");
		logger.info("   - paramMap : " + paramMap);
		
		// 로그인해서 리스트를 먼저 뿌린다.
		// model.addAttribute("writer", session.getAttribute("loginId"));
		// 작성 초기 단계에서 쓰려고 미리 뿌린다.
		// System.out.println("writer : " + session.getAttribute("loginId"));
		
		logger.info("+ End " + className + ".initNotice");
		
		return "notice/notice";
	}
	
	
	/* 공지사항 리스트 뿌리기 */
	@RequestMapping("noticeList.do")
	public String noticeList(Model model, @RequestParam Map<String,Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
			
			// extraction params
			int currentPage = Integer.parseInt((String)paramMap.get("currentPage")); // 현재페이지 
			int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
			int pageIndex = (currentPage -1)*pageSize;
			
			// put parameters into Map
			paramMap.put("pageIndex", pageIndex);
			paramMap.put("pageSize", pageSize);
			
		
			// get notice list
			List<NoticeModel> noticeList = noticeService.noticeList(paramMap);
			
			
			// get notices total 
			int totalCnt = noticeService.noticeTotalCnt(paramMap);
			
			
			// Add attribute
			model.addAttribute("totalCnt", totalCnt);
			model.addAttribute("noticeList", noticeList);
			model.addAttribute("pageSize", pageSize);
			model.addAttribute("currentPage",currentPage);
			
		return "notice/noticeList";	
	}
	
	/* 공지사항 상세 정보 뿌리기 */
	@RequestMapping("detailNoticeList.do")
	@ResponseBody
	public Map<String,Object> detailList(Model model, @RequestParam Map<String,Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		  
		String result="";
		
		// get notice info by ntc_no
		NoticeModel detailNotice = noticeService.detailNotice(paramMap);
		
		// get attch files infos
		List<FileModel> files = noticeService.selectFile(paramMap);
		
		if(detailNotice != null) {
			
			result = "SUCCESS";  // 성공시 찍습니다. 
			
		}else {
			result = "FAIL / 불러오기에 실패했습니다.";  // null이면 실패입니다.
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", detailNotice); 
		
		resultMap.put("files", files);
		
		resultMap.put("manageResult", result); // success 용어 담기 
		
		return resultMap;
	}
	
	
	
	/* 공지사항 등록하기 */
	@RequestMapping("noticeSave.do")
	@PostMapping
	@ResponseBody
	public int savaList(String action, NoticeModel data,HttpServletRequest request) throws Exception {
		
		

		 
		// resultMessage
		int manageResult=0; 
		
		try{
			if("I".equalsIgnoreCase(action)) {
				 // 저장 service
				noticeService.insertNotice(data,request);

				
			}else if("U".equalsIgnoreCase(action)) {
				// noticeService.updateNotice(paramMap,request); // 수정 service

				
			}else if("D".equalsIgnoreCase(action)) {
				// noticeService.deleteNotice(paramMap); // 수정 service

				
			}
			
		}catch(Exception e){
			manageResult =0;
			
		}
		
		
		
		
		
		return manageResult;
	}
	
//	@RequestMapping("fileDown.do")
//	public void downloadBbsAtmtFil(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
//			HttpServletResponse response, HttpSession session) throws Exception {
//	
//		logger.info("+ Start " + className + ".downloadBbsAtmtFil");
//		logger.info("   - paramMap : " + paramMap);
//		
//		// 첨부파일 조회
//		FileModel selectFile = noticeService.selectFile(paramMap);
//		
//		byte fileByte[] = FileUtils.readFileToByteArray(new File(rootPath+selectFile.getFile_new_name()));
//		
//		response.setContentType("application/octet-stream");
//	    response.setContentLength(fileByte.length);
//	    response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(selectFile.getFile_ofname(),"UTF-8")+"\";");
//	    response.setHeader("Content-Transfer-Encoding", "binary");
//	    response.getOutputStream().write(fileByte);
//	     
//	    response.getOutputStream().flush();
//	    response.getOutputStream().close();
//
//		logger.info("+ End " + className + ".fileDown");
//	}
	
	
	
	
	

}
