package com.nexacro.sample.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Validator;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nexacro.sample.service.PcAdminService;
import com.nexacro.sample.vo.AdminPayInfoVO;
import com.nexacro.sample.vo.PCListVO;
import com.nexacro.uiadapter17.spring.core.annotation.ParamDataSet;
import com.nexacro.uiadapter17.spring.core.annotation.ParamVariable;
import com.nexacro.uiadapter17.spring.core.data.NexacroResult;
@Controller
public class PcAdminController {
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);

	@Autowired
	private PcAdminService pcAdminService;

	@Resource
	private Validator validator;
	
	@RequestMapping(value = "/pcroomlist.do")
	public NexacroResult pcroomlist() {
		List<PCListVO> pclist = pcAdminService.getPclist();
		NexacroResult result = new NexacroResult();
		result.addDataSet("pc_room",pclist);
		return result;

	};

	@RequestMapping(value = "/getAvailable.do")
	public NexacroResult getAvailable() {
		List<PCListVO> availaleList = pcAdminService.getAvailble();
		NexacroResult result = new NexacroResult();
		result.addDataSet("pcUser",availaleList);
		return result;

	};
	
	
	@RequestMapping(value = "/pcsetSeat.do")
	public NexacroResult pcsetSeat(@ParamDataSet(name = "pc_send", required = false) Map<String, Object> setMap) {
		System.out.println(setMap.get("loginID"));
		System.out.println(setMap.get("pc_no"));
		String single_using_code = pcAdminService.getMax();
		System.out.println(single_using_code);
		
		setMap.put("single_using_code", single_using_code);
		pcAdminService.setSeat(setMap);
		pcAdminService.setPcSeatUse(setMap);
		
		NexacroResult result = new NexacroResult();
		
		return result;

	};
	@RequestMapping(value = "/pcPaymentInfo.do")
	public NexacroResult pcPaymentInfo(@ParamVariable(name="user",required=false)String user) {
		List<AdminPayInfoVO> list =pcAdminService.getPerchase(user);
		NexacroResult result = new NexacroResult();
		result.addDataSet("ds_payment",list);
		return result;

	};
	
	
	@RequestMapping(value = "/pcStatusUpdate.do")
	public NexacroResult pcStatusUpdate(@ParamDataSet(name = "ds_payment", required = false) Map<String, Object> setMap) {
		System.out.println(setMap.get("loginID"));
		System.out.println(setMap.get("sales_code"));
		
		pcAdminService.setPcroomStatus(setMap);
		pcAdminService.setUserStatus(setMap);
		pcAdminService.setPcusingStatus(setMap);
		pcAdminService.setSalesStatus(setMap);
		
		NexacroResult result = new NexacroResult();
		
		return result;

	};
	
	
}
