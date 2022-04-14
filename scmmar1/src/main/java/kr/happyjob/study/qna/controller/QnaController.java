package kr.happyjob.study.qna.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.qna.exception.ContentNotExistException;
import kr.happyjob.study.qna.exception.NotHaveAuthToWatchQnaException;
import kr.happyjob.study.qna.model.PageInfo;
import kr.happyjob.study.qna.model.SearchParam;
import kr.happyjob.study.qna.service.QnaService;

@Controller
@RequestMapping({"/sti" , "/epc"})
public class QnaController {
	
	private static final String MSG_KEY_VAL="msg";
	private static final String NOT_AUTHORIZED="권한이 없습니다";
	private static final String CONTENT_NOT_EXIST="삭제되었거나 없는 게시글입니다";
	private static final String SERVER_ERR="오류가 발생하였습니다 잠시 후 다시 시도하세요";
	

	
	
	private final Logger logger=LogManager.getLogger(this.getClass());
	
	private QnaService qnaService;
	
	public QnaController() {
	
	}
	
	@Autowired
	public QnaController(QnaService qnaService) {
	
		this.qnaService = qnaService;
	}




	@GetMapping("/inquiry.do")
	public String initQnaMain(HttpSession session, Model model){
		
		model.addAttribute("type",session.getAttribute("userType"));
		
		return "qna/qnaMain";
	}
	
	@PostMapping("/qna/list")
	public String getQnaList(PageInfo info, SearchParam params, HttpSession session,Model model){
		info.setParams(params);
		logger.info(info.getParams().getSelectPage());
		logger.info(info.getParams().getRowsPerPage());
		logger.info(params.getSearchType());
		logger.info(params.getKeyword());
		
		try{
			model.addAttribute("page",qnaService.getQnaList(info,session));
		}catch(Exception e){
			e.printStackTrace();
		
		}
		return "qna/system/qnaList";
	}
	
	/**
	 * 
	 * @param id : 선택한 1:1 문의의 고유번호
	 * @return View 페이지
	 */
	@RequestMapping("/qna/{id}")
	public String getQnaDetail(@PathVariable String id,Model model,HttpSession session){
		
		// 이 문의글 (리소스) 에 접근 할 수 있는 사람은 그 문의글을 쓴 사람과 내부직원 뿐이다.
		
		String targetView="qna/system/qnaInfo";
		
		try{
			
			model.addAttribute("info", qnaService.getQnaDetail(id,session));
			
		}catch(Exception e){
			targetView="redirect:/accessdenied.do";
		}
		return targetView;
	}
	
	
	@RequestMapping("/manage/{action}/{idx}")
	@ResponseBody
	public Map<String, Object> manageQna(@PathVariable(value="action") String action, @PathVariable(value="idx") String qna_id){
		
		logger.info("+ manageQna initiate...");
		
		Map<String,Object> messageMap=new HashMap<String, Object>();
		
		
		try{
			switch(action){
			
			case "REGISTER":
				break;
			case "UPDATE":
				break;
			case "DELETE":
				break;
			}

		}catch(Exception e){
			if(e instanceof NotHaveAuthToWatchQnaException){
				messageMap.put(MSG_KEY_VAL, NOT_AUTHORIZED);
			}else if(e instanceof ContentNotExistException){
				
				messageMap.put(MSG_KEY_VAL, CONTENT_NOT_EXIST);
			}else{
				messageMap.put(MSG_KEY_VAL, SERVER_ERR);
			}
		}
		
		return messageMap;
	}
	
	
}
