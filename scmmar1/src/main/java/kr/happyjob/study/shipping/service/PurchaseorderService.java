package kr.happyjob.study.shipping.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.shipping.model.PurchaseorderModel;

public interface PurchaseorderService {
	
	
	//발주 리스트
	public List<PurchaseorderModel> ListPurchaseOrder(Map<String, Object> paramMap) throws Exception;
	
	//발주 리스트 개수
	public int countListPurchaseOrder(Map<String, Object> paramMap) throws Exception;
	
	//발주 상세
	public PurchaseorderModel selectPurchaseOrder(Map<String, Object> paramMap) throws Exception;
}	
