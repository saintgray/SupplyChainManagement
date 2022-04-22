package kr.happyjob.study.scm.orders.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

@Service
public interface DirService {

	int insertShippingDir(List<String> purIdxList, List<String> exportTarget,String userType, String action);

	int insertOrderDir(List<String> targetWh, HttpSession session) throws Exception;
	

}
