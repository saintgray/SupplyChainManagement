package kr.happyjob.study.scm.refund.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.entity.PurchaseInfo;
import kr.happyjob.study.entity.RefundInfo;
import kr.happyjob.study.scm.orders.service.DirService;
import kr.happyjob.study.scm.refund.exception.NotConfirmedException;
import kr.happyjob.study.scm.refund.model.RefundInfoModel;
import kr.happyjob.study.scm.refund.service.RefundInfoService;



@Controller 
@RequestMapping("/scm/")
public class RefundInfoController {
	
	
	private final Logger logger=LogManager.getLogger(this.getClass());
	
	
	@Autowired
	RefundInfoService refundService;
	@Autowired
	DirService dirService;
	
	
	
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
		
      RefundInfo onereinfo = refundService.oneRefundInfo(paramMap);
      
      model.addAttribute("onereinfo",onereinfo);
		
		
		return"scm/refund/system/refundinfolistlayer";
	}
	
	@RequestMapping("refund/{action}/{idx}")
	@ResponseBody
	public Map<String,Object> refupdate(Model model, @PathVariable String action, @PathVariable String idx) throws Exception{
		 
		int result=0;
		String resultMsg=null;
		Map<String,Object> returnmap = new HashMap<String,Object>();
		
		logger.info("+ action : "+action);
		
		
		try{
			if(action.toLowerCase().equals("writedelivdir")){
				// idx = 반품지시서 고유번호
				logger.info("+ init writedelivdir");
				result=dirService.insertDelivDir(idx);
				
			}else if(action.toLowerCase().equals("writereturndir")){
				// idx = 반품 정보 고유번호
				logger.info("+ init writereturndir");
				result=dirService.insertReturnDir(idx);
			}
			
			if(result>0){
				
				resultMsg = "작성되었습니다";
				
			}
			 
			// refundService.refupdate(paramMap);
		}catch(Exception e){
				if(e instanceof NotConfirmedException){
					resultMsg="임원의 승인이 필요합니다";
				}else{
					resultMsg="오류가 발생하였습니다 잠시 후 다시 시도하세요";
				}
		}finally{
			returnmap.put("resultMsg", resultMsg==null?"널입니다":resultMsg);
		}
		
	      return returnmap;
		 
	 }

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
