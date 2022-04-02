package com.nexacro.sample.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nexacro.sample.service.PayinfoService;
import com.nexacro.uiadapter17.spring.core.annotation.ParamVariable;
import com.nexacro.uiadapter17.spring.core.data.NexacroResult;

@Controller
public class PayInfoController {
	@Autowired
	@Resource(name = "payinfoService")
	private PayinfoService payinfoService;

	@RequestMapping(value = "/payinfo.do")
	// @ParamDataSet 데이터받음
	// 아규먼트 받기 : @ParamVariable
	public NexacroResult selectMap(@ParamVariable(name = "loginId", required = false) String loginId,
			@ParamVariable(name = "using_day", required = false) String using_day) {
		System.out.println("payinfo.do");
		System.out.println("loginId : " + loginId);
		System.out.println("using_day : " + using_day);

		Map<String, Object> payinfo = new HashMap<>();
		payinfo.put("loginId", loginId);
		payinfo.put("using_day", using_day);
		System.out.println("payinfo : " + payinfo);

		List<Map<String, Object>> ds_payinfo = payinfoService.payinfo(payinfo);
		System.out.println("ds_payinfo : " + ds_payinfo);

		NexacroResult result = new NexacroResult();
		result.addDataSet("ds_payinfo", ds_payinfo);
		return result;
	};
}
