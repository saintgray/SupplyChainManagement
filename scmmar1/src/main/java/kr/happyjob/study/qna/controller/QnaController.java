package kr.happyjob.study.qna.controller;

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

import kr.happyjob.study.qna.model.PageInfo;
import kr.happyjob.study.qna.model.SearchParam;
import kr.happyjob.study.qna.service.QnaService;

@Controller
@RequestMapping("/sti")
public class QnaController {

	
	
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
	@PostMapping("/qna/{id}")
	public String getQnaDetail(@PathVariable String id,Model model,HttpSession session){
		
		// 이 문의글 (리소스) 에 접근 할 수 있는 사람은 그 문의글을 쓴 사람과 내부직원 뿐이다.
		
		String targetView="qna/system/qnaInfo";
		
		try{
			
			model.addAttribute("info", qnaService.getQnaDetail(id,session));
			
		}catch(Exception e){
			targetView="redirect:/accessdenied";
		}
		
		
		
		
		
		
		return targetView;
	}
}
