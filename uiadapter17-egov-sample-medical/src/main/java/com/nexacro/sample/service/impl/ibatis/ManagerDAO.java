package com.nexacro.sample.service.impl.ibatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import com.nexacro.spring.dao.ibatis.NexacroIbatisAbstractDAO;

@Repository("managerDAO")
public class ManagerDAO extends NexacroIbatisAbstractDAO {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectUserListMap(Map<String, Object> gcdMap) {
		return (List<Map<String, Object>>) list("manager.selectUserListMap", gcdMap);
	}
	
	@SuppressWarnings("unchecked")
	public void modifyMap(Map<String, Object> searchMap) {
		update("manager.modifyMap", searchMap);
	}

	
	
}
