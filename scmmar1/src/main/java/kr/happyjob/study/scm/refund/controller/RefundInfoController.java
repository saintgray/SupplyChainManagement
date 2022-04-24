package kr.happyjob.study.scm.refund.controller;

import java.util.HashMap;
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
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.entity.PurchaseInfo;
import kr.happyjob.study.scm.refund.model.RefundInfoModel;
import kr.happyjob.study.scm.refund.service.RefundInfoService;



@Controller 
@RequestMapping("/scm/")
public class RefundInfoController {
	
	@Autowired
	RefundInfoService refundService;
	
	@RequestMapping("refundInfo.do")
	public String InitStart() throws Exception{
		return "scm/refund/refundInfo";
	}

	@RequestMapping("refundInfolist.do")
	public String refundInfolist(Model  model, @RequestParam Map<String, Object> paramMap, HttpServletRequest  request,
	   HttpServletResponse  response, HttpSession  session) throws Exception {	
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
	    int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
	    int pageIndex = (currentPage-1)*pageSize;
	      
	      paramMap.put("pageIndex", pageIndex);	
	      paramMap.put("pageSize", pageSize);
	      
	      int total = refundService.total(paramMap);
	      // List<RefundInfoModel> reinfolist = refundService.reinfolist(paramMap);
	      List<PurchaseInfo> reinfolist= refundService.getRefundInfoList(paramMap);
	      
		model.addAttribute("reinfolist",reinfolist);
		model.addAttribute("total",total);
		
		
		return"scm/refund/system/refundInfolist";
	}
	
	@RequestMapping("refundinfolistlayer.do")
	public String onerefundinfo(Model  model, @RequestParam Map<String, Object> paramMap, HttpServletRequest  request,
	   HttpServletResponse  response, HttpSession  session) throws Exception {	
		
	      RefundInfoModel onereinfo = refundService.onereinfo(paramMap);
	      
		model.addAttribute("onereinfo",onereinfo);
		
		
		return"scm/refund/system/refundinfolistlayer";
	}
	
	@RequestMapping("refupdate.do")
	@ResponseBody
	public Map<String,Object> refupdate(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	    HttpServletResponse response, HttpSession session) throws Exception{
		 
		System.out.println(paramMap.get("sales_nm"));
		 
		refundService.refupdate(paramMap);
		
		 Map<String,Object> returnmap = new HashMap<String,Object>();
		 String resultMsg = "승인 요청이 완료 되었습니다.";
		 returnmap.put("resultMsg", resultMsg);
		 
	      return returnmap;
		 
	 }

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
