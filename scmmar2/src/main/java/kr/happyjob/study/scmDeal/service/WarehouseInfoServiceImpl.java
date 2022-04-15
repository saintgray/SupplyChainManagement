package kr.happyjob.study.scmDeal.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scmDeal.dao.WarehouseInfoDAO;
import kr.happyjob.study.scmDeal.model.WarehouseInfo;

@Service
public class WarehouseInfoServiceImpl implements WarehouseInfoService {

	@Autowired
	private WarehouseInfoDAO warehouseInfoDAO; 
	
	/** 창고 목록 조회 */
	@Override
	public List<WarehouseInfo> getList(Map<String, Object> paramMap) throws Exception {
		return warehouseInfoDAO.selectList(paramMap);
	}
	
	/** 창고 목록 총개수 */
	@Override
	public int getTotal(Map<String, Object> paramMap) throws Exception {
		return warehouseInfoDAO.selectListTotal(paramMap);
	}
	
	/** 창고별 상세목록 */
	@Override
	public List<WarehouseInfo> getDetail(Map<String, Object> paramMap) throws Exception {
		return warehouseInfoDAO.selectDetailList(paramMap);
	}
	
	/** 창고별 상세목록 총개수 */
	@Override
	public int getDetailTotal(Map<String, Object> paramMap) throws Exception {
		return warehouseInfoDAO.selectDetailTotal(paramMap);
	}
	
}
