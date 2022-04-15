package kr.happyjob.study.buyImportrtn.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.buyImportrtn.dao.BuyImportReturnDAO;
import kr.happyjob.study.buyImportrtn.model.BuyImportReturn;

@Service
public class BuyImportReturnServiceImpl implements BuyImportReturnService {

	@Autowired
	private BuyImportReturnDAO buyImportReturnDAO;
	
	/** 반품목록조회 */
	@Override
	public List<BuyImportReturn> getReturnList(Map<String, Object> paramMap) throws Exception {
		return buyImportReturnDAO.selectReturnList(paramMap);
	}
	
	/** 반품목록총개수 */
	@Override
	public int getReturnTotal(Map<String, Object> paramMap) throws Exception {
		return buyImportReturnDAO.selectReturnTotal(paramMap);
	}
	
	/** 반품단건조회 */
	@Override
	public BuyImportReturn getReturnOne(Map<String, Object> paramMap) throws Exception {
		return buyImportReturnDAO.selectReturnOne(paramMap);
	}
	
}
