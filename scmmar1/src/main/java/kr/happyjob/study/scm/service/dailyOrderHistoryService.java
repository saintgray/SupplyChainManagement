package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.CompModel;
import kr.happyjob.study.scm.model.DailyOrderHistoryModel;
import kr.happyjob.study.scm.model.WorkOrderModel;
import kr.happyjob.study.scm.model.warehouseModel;

public interface DailyOrderHistoryService {

	// list 조회
	public List<DailyOrderHistoryModel> listdailyOrderHistory(Map<String, Object> paramMap) throws Exception;
	// 총 값
	public int total(Map<String, Object> paramMap) throws Exception;
	// 단건 조회
	public WorkOrderModel onedailyOrderHistory(Map<String, Object> paramMap) throws Exception;
	// 창로 list 조회
	public List<warehouseModel> warehouse() throws Exception;
	//창고 제고 조회
	public warehouseModel whcnt(Map<String,Object> paramMap) throws Exception;
	//납품업체 목록 조회
	public List<CompModel> comp() throws Exception;
	
	//발주지시서 저장
	public int insertcom1(Map<String, Object> paramMap) throws Exception;
	//발주지시서 저장
	public int insertcom2(Map<String, Object> paramMap) throws Exception;
	//반품지시서 저장
	public int insertreturn(Map<String, Object> paramMap) throws Exception;
	//배송지시서 저장
	public int insertdel(Map<String,Object> paramMap) throws Exception;
	//배송지시서 작성 유무 확인
	public DailyOrderHistoryModel comf(Map<String,Object> paramMap) throws Exception; 
	//반품지시서 작성 유무 확인
	public DailyOrderHistoryModel come(Map<String,Object> paramMap) throws Exception; 
	
}