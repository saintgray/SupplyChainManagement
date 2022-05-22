package kr.happyjob.study.scm.orders.controller;

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

import kr.happyjob.study.scm.orders.model.purchaseDirModel;
import kr.happyjob.study.scm.orders.service.purchaseDirService;

@Controller
@RequestMapping("/scm/")
public class PurchaseDirController {
	
	@Autowired
	purchaseDirService purchasedirservice;
	
	@RequestMapping("purchaseDir.do")
	public String InitStart() throws Exception{
		
		return"scm/purchaseDir";
	}

	@RequestMapping("listpurchaseDir.do")
	 public String listinit(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      
	      int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
	      int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
	      int pageIndex = (currentPage-1)*pageSize;
	      
	      paramMap.put("pageIndex", pageIndex);	
	      paramMap.put("pageSize", pageSize);
	      
	      int total = purchasedirservice.total(paramMap);
	      List<purchaseDirModel> listpurchaseDir = purchasedirservice.listpurchaseDir(paramMap);
	      
	      model.addAttribute("total",total);
	      model.addAttribute("listpurchaseDir",listpurchaseDir);
	      
	      return "scm/purchaseDirlist";
	   }  
		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
