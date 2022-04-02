package kr.happyjob.study.scm.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.happyjob.study.scm.model.dailyOrderHistoryModel;
import kr.happyjob.study.scm.service.dailyOrderHistoryService;

@Controller
@RequestMapping("/scm/")
public class dailyOrderHistoryController {
	
	@Autowired
	dailyOrderHistoryService dailyorderhistoryservice;
	
	// 화면 이동
	@RequestMapping("dailyOrderHistory.do")
	public String initApproval(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {
		return "scm/dailyOrderHistory";
	}
	
	
	 @RequestMapping("listdailyOrderHistory.do")
	 public String gouppcodelist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      
	      int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
	      int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
	      int pageIndex = (currentPage-1)*pageSize;
	      
	      paramMap.put("pageIndex", pageIndex);	
	      paramMap.put("pageSize", pageSize);
	      
	      
	      int total = dailyorderhistoryservice.total();
	      List<dailyOrderHistoryModel> listdailyOrderHistory = dailyorderhistoryservice.listdailyOrderHistory(paramMap);
	      
	      model.addAttribute("total",total);
	      model.addAttribute("listdailyOrderHistory",listdailyOrderHistory);
	      
	      
	      return "scm/dailyOrderHistorylist";
	   }  
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
