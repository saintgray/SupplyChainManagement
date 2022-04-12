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
		param.setStartIndex((param.getCurrentPage()-1)*param.getPageBlockSize() +1);
		
		logger.info("---------- search param");
		logger.info(param);
		
		ArrayList<OrderListItemDTO> itemList = rrservice.getOrderList(param);
		/*int totalCnt = rrservice.getTotalOrderListCnt(param);*/
		int totalCnt = 3;
		
		model.addAttribute("totalOrderListCnt", totalCnt);
		model.addAttribute("orderRecordList", itemList);
		
		
		
		return "epc/refundRequestOrderListTbody";
	}
	
	@RequestMapping(value="getOrderDetail", method= RequestMethod.POST)
	public String god(Model model, SearchParamDTO param) {
		param.setStartIndex((param.getCurrentPage()-1) * param.getPageBlockSize() + 1);
		ArrayList<OrderListItemDTO> itemList = rrservice.getOrderDetailList(param);
		/*int totalOrderDetailListCnt = rrservice.getTotalOrderDetailListCnt(param.getPurID());*/
		int totalOrderDetailListCnt = 3;
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
	public int srr(String bank_name, String account_holder, Integer account_number, @RequestParam(value="purinf_id_list[]") ArrayList<Integer> purinf_id_list) { 
		RefundinfoDTO param = new RefundinfoDTO();
		param.setBank_name(bank_name);
		param.setAccount_holder(account_holder);
		param.setAccount_number(account_number);
		param.setPurinf_id_list(purinf_id_list);
		
		logger.info("controller srr print param");
		
		int result = rrservice.insertRefundinfo(param);
		
		return result;
	}
}

