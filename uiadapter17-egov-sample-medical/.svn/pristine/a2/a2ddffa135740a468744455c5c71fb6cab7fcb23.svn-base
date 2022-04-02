package com.nexacro.sample.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nexacro.sample.service.UseListService;
import com.nexacro.uiadapter17.spring.core.annotation.ParamDataSet;
import com.nexacro.uiadapter17.spring.core.annotation.ParamVariable;
import com.nexacro.uiadapter17.spring.core.data.NexacroResult;

@Controller
public class UseListController {

	@Autowired
	@Resource(name = "useListService")
	private UseListService useListService;

	@RequestMapping(value = "/useList.do")
	// @RequestMapping(value = "/useListTest.do")
	// @ParamDataSet 데이터받음
	// 아규먼트 받기 : @ParamVariable
	public NexacroResult selectMap(@ParamDataSet(name = "ds_cal", required = false) Map<String, Object> ds_cal,
			@ParamVariable(name = "loginID", required = false) String loginID) {
		System.out.println("loginID : " + loginID);
		System.out.println("useList~~~");		
		ds_cal.put("loginID", loginID);
		System.out.println("ds_cal : " + ds_cal);
		List<Map<String, Object>> list = useListService.useList(ds_cal);
		System.out.println("list : " + list);

		
		NexacroResult result = new NexacroResult();
		// System.out.println(list.size());
		result.addDataSet("ds_useList", list);
		return result;
	};

	@RequestMapping(value = "/useListOnload.do")
	public NexacroResult selectMap(@ParamVariable(name = "loginID", required = false) String loginID) {
		System.out.println("loginID : " + loginID);
		Map<String, Object> map = new HashMap<>();
		map.put("loginID", loginID);
		List<Map<String, Object>> list = useListService.useListOnload(map);
		System.out.println(list);
		NexacroResult result = new NexacroResult();
		result.addDataSet("ds_useList", list);
		return result;

	}
}
