package kr.happyjob.study.scmStandard.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scmStandard.dao.WhInfoDao;
import kr.happyjob.study.scmStandard.model.WhInfoModel;
import kr.happyjob.study.system.model.ComnCodUtilModel;


@Service
public class WhInfoServiceImpl implements WhInfoService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	WhInfoDao whInfoDao;
	
	/** 창고정보 목록 조회 */
	public List<WhInfoModel> listWarehouseInfo(Map<String, Object> paramMap) throws Exception {
		
		List<WhInfoModel> listWarehouseInfo = whInfoDao.listWarehouseInfo(paramMap);
		
		return listWarehouseInfo;
	}
	
	/** 창고정보 목록 카운트 조회 */
	public int countListWarehouseInfo(Map<String, Object> paramMap) throws Exception {
		
		int totalCount = whInfoDao.countListWarehouseInfo(paramMap);
		
		return totalCount;
	}
	
	/** 창고정보 단건 조회 */
	public WhInfoModel selectWarehouseInfo(Map<String, Object> paramMap) throws Exception {
		
		WhInfoModel warehouseInfoModel = whInfoDao.selectWarehouseInfo(paramMap);
		return warehouseInfoModel;
	}
	
	/** 창고정보 저장 */
	public int insertWarehouseInfo(Map<String, Object> paramMap) throws Exception {
		
		int ret = whInfoDao.insertWarehouseInfo(paramMap);
		
		return ret;
	}
	
	/** 창고정보 수정 */
	public int updateWarehouseInfo(Map<String, Object> paramMap) throws Exception {
		
		int ret = whInfoDao.updateWarehouseInfo(paramMap);
		return ret;
	}
	
	/** 창고정보 삭제 */
	public int deleteWarehouseInfo(Map<String, Object> paramMap) throws Exception {
		
		int ret = whInfoDao.deleteWarehouseInfo(paramMap);
		
		return ret;
	}
	
	/** 창고담당자 목록 조회 */
	public List<ComnCodUtilModel> mgrnmList (Map<String, Object> paramMap) throws Exception{
		
		List<ComnCodUtilModel> mgrnmList = whInfoDao.mgrnmList(paramMap);
		
		return mgrnmList;
	}
	
	
}