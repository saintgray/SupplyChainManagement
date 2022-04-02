package com.nexacro.sample.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.nexacro.sample.service.PayinfoService;
import com.nexacro.sample.service.impl.ibatis.PayInfoDAO;

@Service("payinfoService")
public class PayInfoServiceImpl implements PayinfoService {
	@Resource(name = "payinfoDAO")
	private PayInfoDAO payinfoDAO;

	@Override
	public List<Map<String, Object>> payinfo(Map<String, Object> payinfo) {
		List<Map<String, Object>> list = payinfoDAO.payinfo(payinfo);
		System.out.println("payinfo serviceimpl : "+list);
		return list;
	}

}
