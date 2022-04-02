package com.nexacro.sample.service;

import java.util.List;
import java.util.Map;

public interface ManagerService {

	List<Map<String, Object>> selectUserListMap(Map<String, Object> searchMap);

	void modifyMap(Map<String, Object> searchMap);

}
