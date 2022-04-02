package com.nexacro.sample.service.impl.ibatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.nexacro.spring.dao.ibatis.NexacroIbatisAbstractDAO;

@Repository("useListDAO")
public class UseListDAO extends NexacroIbatisAbstractDAO {
	public List<Map<String, Object>> useList(Map<String, Object> gcdMap) {
		System.out.println("uselistdao:" + gcdMap);
		return (List<Map<String, Object>>) list("useList.useList", gcdMap);
	}

	public List<Map<String, Object>> useListOnload(Map<String, Object> loginID) {
		return (List<Map<String, Object>>) list("useList.useListOnload", loginID);
	}
}
