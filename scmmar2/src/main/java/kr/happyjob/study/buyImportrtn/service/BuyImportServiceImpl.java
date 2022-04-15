package kr.happyjob.study.buyImportrtn.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.buyImportrtn.dao.BuyImportDAO;
import kr.happyjob.study.buyImportrtn.model.BuyImport;

@Service
public class BuyImportServiceImpl implements BuyImportService {
	
	@Autowired
	private BuyImportDAO buyImportrtnDAO;
	
	/** 발주지시서 목록 */
	@Override
	public List<BuyImport> selectImportList(Map<String, Object> paramMap) throws Exception {
		return buyImportrtnDAO.selectImportList(paramMap);
	}
	
	/** 발주지시서 목록 총 개수 */
	@Override
	public int selectImportTotal(Map<String, Object> paramMap) throws Exception {
		return buyImportrtnDAO.selectImportTotal(paramMap);
	}
	
	/** 발주지시서 단건 조회 */
	@Override
	public BuyImport selectImportOne(Map<String, Object> paramMap) throws Exception {
		return buyImportrtnDAO.selectImportOne(paramMap);
	}

	@Override
	public int updatePayY(Map<String, Object> paramMap) throws Exception {
		return buyImportrtnDAO.updatePayY(paramMap);
	}

	@Override
	public int returnInsert(Map<String, Object> paramMap) throws Exception {
		
		int result = buyImportrtnDAO.returnInsert(paramMap); 
		
		if(result>0){
			int result2 = buyImportrtnDAO.returnInsertDetail(paramMap);
			if(result2>0){
				buyImportrtnDAO.returnInsertDelivery(paramMap);
			}
			
		}
		
		return result; 
	}

	
	
}
