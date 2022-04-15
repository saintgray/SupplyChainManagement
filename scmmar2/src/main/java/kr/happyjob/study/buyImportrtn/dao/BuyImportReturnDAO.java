package kr.happyjob.study.buyImportrtn.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.buyImportrtn.model.BuyImportReturn;

public interface BuyImportReturnDAO {
	
	/** 반품목록조회 */
	public List<BuyImportReturn> selectReturnList(Map<String, Object> paramMap) throws Exception;

	/** 반품목록총개수 */
	public int selectReturnTotal(Map<String, Object> paramMap) throws Exception;
	
	/** 반품단건조회 */
	public BuyImportReturn selectReturnOne(Map<String, Object> paramMap) throws Exception;

}
