package kr.happyjob.study.scmStandard.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scmStandard.model.SupplierInfoModel;


public interface SupplierInfoService {

	/** 납품업체정보 목록 조회 */
	public List<SupplierInfoModel> listSupplierInfo(Map<String, Object> paramMap) throws Exception;
	
	/** 납품업체정보 목록 카운트 조회 */
	public int countListSupplierInfo(Map<String, Object> paramMap) throws Exception;
	
	/** 납품업체정보 단건 조회 */
	public  List<SupplierInfoModel>  selectSupplierInfo(Map<String, Object> paramMap) throws Exception;
	
	/** 업체별 제품정보 목록 카운트 조회 */
	public int countListSupplierProInfo(Map<String, Object> paramMap) throws Exception;
	
}
