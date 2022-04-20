package kr.happyjob.study.epc.controller;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.epc.model.OrderListItemDTO;
import kr.happyjob.study.epc.model.RefundinfoDTO;
import kr.happyjob.study.epc.model.SearchParamDTO;
import kr.happyjob.study.epc.service.RefundRequestService;

@Controller
@RequestMapping(value="/epc")
public class RefundRequestController {

	@Autowired
	RefundRequestService rrservice;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
		
	
	@RequestMapping(value="refundrequest.do", method=RequestMethod.GET)
	public String rr(Model model) {
		model.addAttribute("currentPageOrderList", 1);
		model.addAttribute("currentPageOrderDetailList", 1);
		return "epc/refundRequest";
	}
	
	
	@RequestMapping(value="getOrderList", method= {RequestMethod.POST})
	public String gol(Model model, HttpSession session, SearchParamDTO param) {
		
		param.setLoginID((String)session.getAttribute("loginId"));
		param.setStartIndex((param.getCurrentPage()-1)*param.getPageBlockSize());
		
		logger.info("---------- search param");
		logger.info(param);
		
		ArrayList<OrderListItemDTO> itemList = rrservice.getOrderList(param);
		int totalCnt = rrservice.getTotalOrderListCnt(param);
		
		model.addAttribute("totalOrderListCnt", totalCnt);
		model.addAttribute("orderRecordList", itemList);
		
		
		
		return "epc/refundRequestOrderListTbody";
	}
	
	@RequestMapping(value="getOrderDetail", method= RequestMethod.POST)
	public String god(Model model, SearchParamDTO param) {
		
		param.setStartIndex((param.getCurrentPage()-1) * param.getPageBlockSize());
		ArrayList<OrderListItemDTO> itemList = rrservice.getOrderDetailList(param);
		int totalOrderDetailListCnt = rrservice.getTotalOrderDetailListCnt(param.getPurID());
		
		model.addAttribute("orderDetailList", itemList);
		model.addAttribute("totalOrderDetailListCnt", totalOrderDetailListCnt);
		
		logger.info("---------- getOrderDetail itemList");
		logger.info(itemList);
		
		
		return "epc/refundRequestOrderDetailTbody";
	}
	
	
	@RequestMapping(value="getBankNameList", method={RequestMethod.GET})
	@ResponseBody
	public ArrayList<String> gbnl() {
		ArrayList<String> result = rrservice.getBankNameList();
		return result;
		
	}
	
	@RequestMapping(value="sendRefundRequest", method={RequestMethod.POST})
	@ResponseBody
	public int srr(
				String bank_name,
				String account_holder,
				String account_number,
				@RequestParam(value="checkedPurinfIdList[]") ArrayList<Integer> checkedPurinfIdList,
				@RequestParam(value="checkedReturnCntList[]") ArrayList<Integer> checkedReturnCntList,
				HttpServletRequest request
				) { 
				
		//verbose params
	    Enumeration<?> params = request.getParameterNames();
	    while (params.hasMoreElements()){
	        String name = (String)params.nextElement();
	        System.out.println(name + " : " +request.getParameter(name));
	    }
	    //verbose params
	    RefundinfoDTO param = new RefundinfoDTO();
	    param.setAccount_holder(account_holder);
	    param.setAccount_number(account_number);
	    param.setBank_name(bank_name);
	    param.setCheckedPurinfIdList(checkedPurinfIdList);
	    param.setCheckedReturnCntList(checkedReturnCntList);
		
		logger.info("controller srr print param");
		logger.info(param);
		
		int result = rrservice.insertRefundinfo(param);
		
		return result;
	}
	
	@RequestMapping(value="deleteRefundinfoByPurinfID", method={RequestMethod.POST})
	@ResponseBody
	public int drbp(int purinf_id) {
		int result = rrservice.deleteRefundinfoByPurinfID(purinf_id);
		return result;
		
	}
}

