package kr.happyjob.study.scm.refund.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.happyjob.study.entity.RefundInfo;
import kr.happyjob.study.scm.orders.service.DirService;
import kr.happyjob.study.scm.refund.exception.NotConfirmedException;
import kr.happyjob.study.scm.refund.service.RefundInfoService;

@RestController
@RequestMapping("/scm/vue")
public class VueRefundInfoController {

	private final Logger logger = LogManager.getLogger(this.getClass());

	private RefundInfoService refundService;
	private DirService dirService;

	@Autowired
	public VueRefundInfoController(RefundInfoService refundService, DirService dirService) {
		this.refundService = refundService;
		this.dirService = dirService;
	}

//@PostMapping("refunds")
	@GetMapping("/refunds")	
	public Map<String,Object> refundInfolist(@RequestParam Map<String, Object> paramMap ,HttpServletResponse response) throws Exception {
	//public Map<String,Object> refundInfolist(@RequestBody ParamsVO params ,HttpServletResponse response) throws Exception {
		
		int currentPage = Integer.parseInt(paramMap.get("currentPage").toString()); 
		int pageSize = Integer.parseInt(paramMap.get("pageSize").toString());
		int totalPage=Integer.parseInt(paramMap.get("totalPage").toString());
		int pageIndex = (currentPage - 1) * pageSize;
		
		
		int total = refundService.total(paramMap);
		if(total>0){
			
			totalPage=total/pageSize;
			totalPage=total%pageSize==0?totalPage:totalPage+1;
			
			paramMap.put("pageIndex", pageIndex);
			paramMap.put("pageSize", pageSize);
			paramMap.put("refunds", refundService.getRefundInfoList(paramMap));			
		}else{
			totalPage=1;
		}
		
		currentPage=currentPage>totalPage?totalPage:currentPage;
		paramMap.put("currentPage", currentPage);
		paramMap.put("total", total);
		paramMap.put("totalPage", totalPage);
		
		Map<String, Object> result= new HashMap<>();
		result.put("param", paramMap);
		
		return result;
	}

	@RequestMapping("refundinfolistlayer.do")
	public String onerefundinfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		RefundInfo onereinfo = refundService.oneRefundInfo(paramMap);

		model.addAttribute("onereinfo", onereinfo);

		return "scm/refund/system/refundinfolistlayer";
	}

	@RequestMapping("refund/{action}/{idx}")
	@ResponseBody
	public Map<String, Object> refupdate(Model model, @PathVariable String action, @PathVariable String idx)
			throws Exception {

		int result = 0;
		String resultMsg = null;
		Map<String, Object> returnmap = new HashMap<String, Object>();

		logger.info("+ action : " + action);

		try {
			if (action.toLowerCase().equals("writedelivdir")) {
				// idx = 반품지시서 고유번호
				logger.info("+ init writedelivdir");
				result = dirService.insertDelivDir(idx);

			} else if (action.toLowerCase().equals("writereturndir")) {
				// idx = 반품 정보 고유번호
				logger.info("+ init writereturndir");
				result = dirService.insertReturnDir(idx);
			}

			if (result > 0) {

				resultMsg = "작성되었습니다";

			}

			// refundService.refupdate(paramMap);
		} catch (Exception e) {
			if (e instanceof NotConfirmedException) {
				resultMsg = "임원의 승인이 필요합니다";
			} else {
				resultMsg = "오류가 발생하였습니다 잠시 후 다시 시도하세요";
			}
		} finally {
			returnmap.put("resultMsg", resultMsg == null ? "널입니다" : resultMsg);
		}

		return returnmap;

	}

}
