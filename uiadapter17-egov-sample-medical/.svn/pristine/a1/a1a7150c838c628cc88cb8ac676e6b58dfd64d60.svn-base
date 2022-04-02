package com.nexacro.sample.service.impl;

import java.util.List;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.nexacro.sample.service.BoardService;
import com.nexacro.sample.service.ManagerService;
import com.nexacro.sample.service.impl.ibatis.ManagerDAO;

@Service("managerService")
public class ManagerServiceImpl implements ManagerService{
	
	private Logger logger = LoggerFactory.getLogger(BoardService.class);
	
	@Resource(name = "managerDAO")
	private ManagerDAO managerDAO;
	
	
	@Override
	public List<Map<String, Object>> selectUserListMap(Map<String, Object> searchMap) {
		return managerDAO.selectUserListMap(searchMap);
	}


	@Override
	public void modifyMap(Map<String, Object> searchMap) {
		managerDAO.modifyMap(searchMap);
	}

}
