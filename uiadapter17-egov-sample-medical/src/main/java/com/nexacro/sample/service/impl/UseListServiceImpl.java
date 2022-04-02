package com.nexacro.sample.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.nexacro.sample.service.UseListService;
import com.nexacro.sample.service.impl.ibatis.UseListDAO;

@Service("useListService")
public class UseListServiceImpl implements UseListService {
	@Resource(name = "useListDAO") // ????
	private UseListDAO useListDAO;

	@Override
	public List<Map<String, Object>> useList(Map<String, Object> searchList) {
		// TODO Auto-generated method stub
		return useListDAO.useList(searchList);
	}

	@Override
	public List<Map<String, Object>> useListOnload(Map<String, Object> loginID) {
		// TODO Auto-generated method stub
		return useListDAO.useListOnload(loginID);
	}
}
