package kr.happyjob.study.scm.orders.service;

import java.util.List;

import org.springframework.stereotype.Service;

@Service
public interface DirService {

	int insertShippingDir(List<String> purIdxList, List<String> exportTarget,String userType, String action);
	

}
