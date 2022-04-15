package kr.happyjob.study.buyImportrtn.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.buyImportrtn.model.BuyImportReturn;

public interface BuyImportReturnService {
	
	/** 반품목록조회 */
	public List<BuyImportReturn> getReturnList(Map<String, Object> paramMap) throws Exception;

	/** 반품목록총개수 */
	public int getReturnTotal(Map<String, Object> paramMap) throws Exception;
	
	/** 반품단건조회 */
	public BuyImportReturn getReturnOne(Map<String, Object> paramMap) throws Exception;
	
}
