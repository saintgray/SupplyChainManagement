package kr.happyjob.study.system.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.system.model.NoticeDTO;
import kr.happyjob.study.system.model.NoticeModel;
import kr.happyjob.study.system.model.PagingVo;
import kr.happyjob.study.system.service.NoticeService;



@Controller
//@RequestMapping("/system/")
@RequestMapping("/sup/")
public class NoticeController {
	
	@Autowired
	private NoticeService noticeService;
	
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	//이전 공지사항
	/*
	// 처음 로딩될 때 공지사항 연결
	@RequestMapping("notice.do")
	public String init(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".initNotice");
		logger.info("   - paramMap : " + paramMap);
		
		String loginID = (String) session.getAttribute("loginId");
		paramMap.put("loginID", loginID);
		System.out.println(loginID);
//		paramMap.put("writer", loginID);
		
		return "system/notice";
	}
	
	// 공지사항 리스트 출력
	@RequestMapping("noticeList.do")
	public String noticeList(Model model, @RequestParam Map<String, Object> paramMap, 
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("   - paramMap : " + paramMap);
		String title = (String) paramMap.get("title");
		
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재페이지
	    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
	    int pageIndex = (currentPage - 1) * pageSize;
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		paramMap.put("title", title);
		
		// 공지사항 목록 조회
		List<NoticeModel> noticeList = noticeService.noticeList(paramMap);
		model.addAttribute("notice", noticeList);
		
		// 목록 수 추출해서 보내기
		int noticeCnt = noticeService.noticeCnt(paramMap);
		
	    model.addAttribute("noticeCnt", noticeCnt);
	    model.addAttribute("pageSize", pageSize);
	    model.addAttribute("currentPage",currentPage);
	    
	    return "system/noticeList";
	}
	
	// 공지사항 상세 조회
	@RequestMapping("detailNotice.do")
	@ResponseBody
	public Map<String,Object> detailNotice(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		//System.out.println("상세정보 보기를 위한 param에서 넘어온 값을 찍어봅시다.: " + paramMap);
		  logger.info("+ Start " + className + ".detailNotice");
		  logger.info("   - paramMap : " + paramMap);
		  
		String result="";
		
		// 선택된 게시판 1건 조회 
		NoticeModel detailNotice = noticeService.noticeDetail(paramMap);
		
		if(detailNotice != null) {
			result = "SUCCESS";  // 성공시 찍습니다. 
		}else {
			result = "FAIL / 불러오기에 실패했습니다.";  // null이면 실패입니다.
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("resultMsg", result); // success 용어 담기 
		resultMap.put("result", detailNotice); // 리턴 값 해쉬에 담기 
		//resultMap.put("resultComments", comments);
		System.out.println(detailNotice);
		
		logger.info("+ End " + className + ".detailNotice");
	    
	    return resultMap;
	}
	
	// 공지사항 신규등록, 업데이트
	@RequestMapping("noticeSave.do")
	@ResponseBody
	public Map<String, Object> noticeSave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".noticeSave");
		logger.info("   - paramMap : " + paramMap);
		
		String action = (String)paramMap.get("action");
		String resultMsg = "";
		
		// 사용자 정보 설정
		paramMap.put("loginId", session.getAttribute("loginId"));
		
		logger.info("loginId : " + paramMap.get("loginId"));
		
		if ("I".equals(action)) {
			// 그룹코드 신규 저장
			noticeService.insertNotice(paramMap);
			resultMsg = "SUCCESS";
		} else if("U".equals(action)) {
			// 그룹코드 수정 저장
			noticeService.updateNotice(paramMap);
			resultMsg = "UPDATED";
			System.out.println(paramMap);
		} else {
			resultMsg = "FALSE : 등록에 실패하였습니다.";
		}
		
		//결과 값 전송
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("resultMsg", resultMsg);
	    
	    return resultMap;
	}
	
	// 공지사항 삭제
	@RequestMapping("noticeDelete.do")
	@ResponseBody
	public Map<String, Object> noticeDelete(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".noticeDelete");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "삭제 되었습니다.";
		
		// 그룹코드 삭제
		noticeService.deleteNotice(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".noticeDelete");
		
		return resultMap;
	}
	*/
	
	@RequestMapping("notice.do")
	public String selectNoticeList(Model model) throws Exception{
		Map<String,Object> map = new HashMap<String,Object>();
		List<NoticeDTO> noticeList = null;
		RowBounds rb = null;
		PagingVo noticeListPaging = null;
		int noticeListCnt;
		String noticeSearchKind = "title";
		String noticeSearchKeyword = "%%";		
		map.put("noticeSearchKind", noticeSearchKind);
		map.put("noticeSearchKeyword", noticeSearchKeyword);
		map.put("sortCondition", "desc");
		noticeListCnt = noticeService.selectListCnt(map);
		noticeListPaging = new PagingVo(noticeListCnt, 1, 10, 10);
		rb = new RowBounds(noticeListPaging.getStart()-1, noticeListPaging.getCntPerPage());
		
		noticeList = noticeService.selectList(map, rb);
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("noticeListPaging", noticeListPaging);
		
		
		
		return "sup/noticeList";
		
	}
	
	@RequestMapping("noticeListMovePage.do")
	@ResponseBody
	public Map<String,Object> noticeListMovePage(@RequestParam(name = "nowPage", defaultValue = "1") int nowPage
									, @RequestParam(name = "searchKind", defaultValue = "title") String searchKind
									,String searchKeyword, String sortCondition) throws Exception{
		Map<String,Object> map = new HashMap<String,Object>();
		Map<String,Object> resultMap = new HashMap<String,Object>();
		List<NoticeDTO> noticeList = null;
		RowBounds rb = null;
		PagingVo noticeListPaging = null;
		int noticeListCnt;
		String noticeSearchKind = null;
		String noticeSearchKeyword = null;
		noticeSearchKind = searchKind;
		if(searchKeyword==null||searchKeyword.trim()==""){
			noticeSearchKeyword = "%%";
		}else{
			noticeSearchKeyword = "%"+searchKeyword+"%";
		}		
		map.put("noticeSearchKind", noticeSearchKind);
		map.put("noticeSearchKeyword", noticeSearchKeyword);
		map.put("sortCondition", sortCondition);
		
		noticeListCnt = noticeService.selectListCnt(map);
		noticeListPaging = new PagingVo(noticeListCnt, nowPage, 10, 10);
		rb = new RowBounds(noticeListPaging.getStart()-1, noticeListPaging.getCntPerPage());
		
		noticeList = noticeService.selectList(map, rb);
		
		resultMap.put("noticeList", noticeList);
		resultMap.put("noticeListPaging", noticeListPaging);
		
		
		
		
		return resultMap;
		
	}
	
	@RequestMapping("insertNotice.do")
	public String insertNotice(NoticeDTO notice, Model model) throws Exception{
		notice.setBoard_Content(notice.getBoard_Content().replaceAll("\r\n", "<br>"));
		noticeService.insertNotice(notice);
		
		return "redirect:/sup/notice.do"; 
		
		
	}
	
	@RequestMapping("noticeDetail.do")
	public String selectDetail(int board_No, Model model) throws Exception{
		NoticeDTO notice = null;
		String noticeUpdateContent = null;
		notice = noticeService.selectDetail(board_No);
		noticeUpdateContent = notice.getBoard_Content().replaceAll("<br>","\r\n");
		model.addAttribute("notice", notice);
		model.addAttribute("noticeUpdateContent", noticeUpdateContent);
		return "sup/noticeDetail";
		
	}
	
	@RequestMapping("updateNotice.do")
	public String updateNotice(NoticeDTO notice, Model model) throws Exception{
		NoticeDTO temp = null;
		notice.setBoard_Content(notice.getBoard_Content().replaceAll("\r\n", "<br>"));
		noticeService.updateNotice(notice);
		return "redirect:/sup/noticeDetail.do?board_No="+notice.getBoard_No();
		
	}

	@RequestMapping("deleteNotice.do")
	public String deleteNotice(int board_No) throws Exception{
		noticeService.deleteNotice(board_No);
		return "redirect:/sup/notice.do"; 
		
	}
	
	@RequestMapping("job.do")
	public String job() throws Exception{
		return "sup/aaaa"; 
		
	}
	
	
	
	
}
