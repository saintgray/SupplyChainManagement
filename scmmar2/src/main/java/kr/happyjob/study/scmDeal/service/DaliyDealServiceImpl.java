package kr.happyjob.study.scmDeal.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scmDeal.dao.DailyDealDAO;
import kr.happyjob.study.scmDeal.model.DailyDeal;

@Service
public class DaliyDealServiceImpl implements DaliyDealService {

	@Autowired
	private DailyDealDAO dailyDealDao;	
	
	/** 수주 목록 조회 */
	@Override
	public List<DailyDeal> getList(Map<String, Object> paramMap) throws Exception {
		return dailyDealDao.selectList(paramMap);
	}
	
	/** 수주 목록 총개수 */
	@Override
	public int getTotalCount(Map<String, Object> paramMap) throws Exception {
		return dailyDealDao.selectListTotal(paramMap);
	}
	
	/** 수주 단건 조회 */
	@Override
	public DailyDeal getOne(Map<String, Object> paramMap) throws Exception {
		return dailyDealDao.selectOne(paramMap);
	}
	
	/** 배송담당 직원 목록 조회 */
	@Override
	public List<DailyDeal> getDeliveryMen(Map<String, Object> paramMap) throws Exception {
		return dailyDealDao.selectEmployeeList(paramMap);
	}
	
	/** 1) 창고 목록 조회 */
	@Override
	public List<DailyDeal> getWarhouses(Map<String, Object> paramMap) throws Exception {
		return dailyDealDao.selectWhList(paramMap);
	}
	
	/** 2) 창고별 제품 목록 조회 */
	@Override
	public List<DailyDeal> getProductList(Map<String, Object> paramMap) throws Exception {
		return dailyDealDao.selectPdList(paramMap);
	}
	
	/** 3) 장고별 제품별 재소수량 조회 */
	@Override
	public int getStTotalCount(Map<String, Object> paramMap) throws Exception {
		return dailyDealDao.selectStCount(paramMap);
	}
	
	/** 배송 정보 저장 */
	@Override
	public int saveDeliveryInfo(Map<String, Object> paramMap) throws Exception {
		return dailyDealDao.insertDelivery(paramMap);
	}
	
	/** 재고 정보 수정 */
	@Override
	public int modifyStockInfo(Map<String, Object> paramMap) throws Exception {
		return dailyDealDao.updateStock(paramMap);	
	}
	
	/** 납품회사 목록 조회 */
	@Override
	public List<DailyDeal> getComList(Map<String, Object> paramMap) throws Exception {
		return dailyDealDao.selectComList(paramMap);
	}
	
	/** 납품 정보 저장 */
	@Override
	public int saveImport(Map<String, Object> paramMap) throws Exception {
		return dailyDealDao.insertImport(paramMap);
	}
	
	/** 납품 디테일 정보 저장 */
	@Override
	public int saveImportDetai(Map<String, Object> paramMap) throws Exception {
		return dailyDealDao.insertImportDetail(paramMap);
	}
	
}
