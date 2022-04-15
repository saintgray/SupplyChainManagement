package kr.happyjob.study.buyImportrtn.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.buyImportrtn.model.BuyImport;

public interface BuyImportService {

	/** 발주지시서 목록 */
	public List<BuyImport> selectImportList(Map<String, Object> paramMap) throws Exception;
	
	/** 발주지시서 목록 총 개수 */
	public int selectImportTotal(Map<String, Object> paramMap) throws Exception;
	
	/** 발주지시서 단건 조회 */
	public BuyImport selectImportOne(Map<String, Object> paramMap) throws Exception;

	public int updatePayY(Map<String, Object> paramMap) throws Exception;

	public int returnInsert(Map<String, Object> paramMap) throws Exception;
	
}
