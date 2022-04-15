package kr.happyjob.study.crtCs.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.happyjob.study.crtCs.model.CrtCsModel;
import kr.happyjob.study.crtCs.service.CrtCsService;
import kr.happyjob.study.crtOrder.model.CrtOrderModel;

@Controller
@RequestMapping("/crt/")
public class CrtCsController {

	@Autowired
	CrtCsService crtCsService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	//1:1 문의 초기화면
	@RequestMapping("inquiry.do")
	public String cartInit(Model model, HttpSession session) {
		return "crtCs/crtQnA";
	}
	
	
	//1:1 문의 등록
	@RequestMapping("insertNewQuestion.do")
	@ResponseBody
	public Map<String,Object> insertNewQuestion(Model model, HttpSession session, @RequestParam Map<String,Object> paramMap) {
		
		
		paramMap.put("loginID", (String)session.getAttribute("loginId"));
		
		int result = crtCsService.insertNewQuestion(paramMap);
		
		String successMsg ="";
		String resultMsg = "";
		Map<String,Object> resultMap = new HashMap<String,Object>();		
		
		
		if(result>0){
			successMsg = "SUCCESS";
			resultMsg = "1:1 문의 등록이 완료되었습니다.";
			resultMap.put("successMsg", successMsg);
			resultMap.put("resultMsg", resultMsg);
			
		}else{
			resultMsg = "1:1 문의 등록 실패";
			resultMap.put("resultMsg", resultMsg);
		}
		
		return resultMap;
	}
	
	
	   //1:1문의 리스트 조회
		@RequestMapping("selectQnAlist.do")
		public ModelAndView selectQnAlist(ModelAndView mv, @RequestParam Map<String,Object> paramMap,HttpSession session){
			
			int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
			int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
			int pageIndex = (currentPage-1)*pageSize;			
			
			paramMap.put("pageIndex", pageIndex);
			paramMap.put("pageSize", pageSize);
			paramMap.put("loginID", (String)session.getAttribute("loginId"));
			
			//제품 리스트 조회
			List<CrtCsModel> listCrtCsModel = crtCsService.selectQnAlist(paramMap);
			mv.addObject("listCrtCsModel",listCrtCsModel);
			
			//제품 리스트 카운트 조회
			int totalCount = crtCsService.countQnAlist(paramMap);
			mv.addObject("totalCntqnalist", totalCount);
			
			mv.addObject("pageSize", pageSize);
			mv.addObject("currentPageQnaList",currentPage);
			
			mv.setViewName("crtCs/crtQnaList");
			
			return mv;
		}
		
		//1:1문의 상세보기
		@RequestMapping("selectQnaOne.do")
		@ResponseBody
		public Map<String,Object> selectQnaOne(@RequestParam Map<String,Object> paramMap,HttpSession session){
			
			paramMap.put("loginID", (String)session.getAttribute("loginId"));
			CrtCsModel crtCsModel = crtCsService.selectQnaOne(paramMap);
			
			Map<String,Object> resultMap = new HashMap<String,Object>();
			
			resultMap.put("crtCsModel", crtCsModel);
			
			return resultMap;
			
		}
		
		//1:1문의 수정
		@RequestMapping("updateQna.do")
		@ResponseBody
		public Map<String,Object> updateQna(Model model, HttpSession session, @RequestParam Map<String,Object> paramMap) {
			
			
			paramMap.put("loginID", (String)session.getAttribute("loginId"));
			
			int result = crtCsService.updateQna(paramMap);
			
			String successMsg ="";
			String resultMsg = "";
			Map<String,Object> resultMap = new HashMap<String,Object>();		
			
			
			if(result>0){
				successMsg = "SUCCESS";
				resultMsg = "1:1 문의 수정이 완료되었습니다.";
				resultMap.put("successMsg", successMsg);
				resultMap.put("resultMsg", resultMsg);
				
			}else{
				resultMsg = "1:1 문의 수정 실패";
				resultMap.put("resultMsg", resultMsg);
			}
			
			return resultMap;
		}
		
		//1:1문의 삭제
				@RequestMapping("deleteQna.do")
				@ResponseBody
				public Map<String,Object> deleteQna(Model model, HttpSession session, @RequestParam Map<String,Object> paramMap) {
					
					
					paramMap.put("loginID", (String)session.getAttribute("loginId"));
					
					int result = crtCsService.deleteQna(paramMap);
					
					String successMsg ="";
					String resultMsg = "";
					Map<String,Object> resultMap = new HashMap<String,Object>();		
					
					
					if(result>0){
						successMsg = "SUCCESS";
						resultMsg = "삭제가 완료되었습니다.";
						resultMap.put("successMsg", successMsg);
						resultMap.put("resultMsg", resultMsg);
						
					}else{
						resultMsg = "삭제 실패";
						resultMap.put("resultMsg", resultMsg);
					}
					
					return resultMap;
				}
}
