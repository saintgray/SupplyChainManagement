package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.oneshipModel;
import kr.happyjob.study.scm.model.shippingDirectionModel;

public interface shippingDirectionService {

	// list 조회
	public List<shippingDirectionModel> listship(Map<String, Object> paramMap) throws Exception;
	// 총 값
	public int total(Map<String, Object> paramMap) throws Exception;
	// 단건 조회
	public oneshipModel onesip(Map<String,Object> paramMap) throws Exception;
	
}
