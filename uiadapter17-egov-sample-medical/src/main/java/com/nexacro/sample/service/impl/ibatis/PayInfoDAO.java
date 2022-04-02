package com.nexacro.sample.service.impl.ibatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.nexacro.spring.dao.ibatis.NexacroIbatisAbstractDAO;

@Repository("payinfoDAO")
public class PayInfoDAO extends NexacroIbatisAbstractDAO {
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> payinfo(Map<String, Object> payinfo) {
		System.out.println("payinfodao : "+payinfo);
		return (List<Map<String, Object>>) list("payinfo.payinfo", payinfo);
	}
}
