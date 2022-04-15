package kr.happyjob.study.scmStandard.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scmStandard.dao.SupplierInfoDao;
import kr.happyjob.study.scmStandard.model.SupplierInfoModel;
import kr.happyjob.study.system.model.ComnGrpCodModel;


@Service
public class SupplierInfoServiceImpl implements SupplierInfoService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	SupplierInfoDao supplierInfoDao;
	
	/** 납품업체정보 목록 조회 */
	public List<SupplierInfoModel> listSupplierInfo(Map<String, Object> paramMap) throws Exception {
		
		List<SupplierInfoModel> listSupplierInfo = supplierInfoDao.listSupplierInfo(paramMap);
		
		return listSupplierInfo;
	}
	
	/** 납품업체정보 목록 카운트 조회 */
	public int countListSupplierInfo(Map<String, Object> paramMap) throws Exception {
		
		int totalCount = supplierInfoDao.countListSupplierInfo(paramMap);
		
		return totalCount;
	}
	
	/** 업체별 제품정보 목록 조회 */
	public  List<SupplierInfoModel> selectSupplierInfo(Map<String, Object> paramMap) throws Exception {
		
		 List<SupplierInfoModel>  supplierInfoModel = supplierInfoDao.selectSupplierInfo(paramMap);
		return supplierInfoModel;
	}
	
	/** 업체별 제품정보 목록 카운트 조회 */
	public int countListSupplierProInfo(Map<String, Object> paramMap) throws Exception{
		
		int totalSupCount = supplierInfoDao.countListSupplierProInfo(paramMap);
		
		return totalSupCount;
	}
	
	
}