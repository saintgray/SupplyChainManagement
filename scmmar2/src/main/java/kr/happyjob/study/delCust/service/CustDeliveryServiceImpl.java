package kr.happyjob.study.delCust.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.delCust.dao.CustDeliveryDao;
import kr.happyjob.study.delCust.model.CustDeliveryModel;

@Service
public class CustDeliveryServiceImpl implements CustDeliveryService {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
			
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	CustDeliveryDao custDeliveryDao;
		
	/** 목록 조회 */
	public List<CustDeliveryModel> listCustDelivery(Map<String, Object> paramMap) throws Exception {
		//List<CustDeliveryModel> listCustDelivery = custDeliveryDao.listCustDelivery(paramMap);
		return custDeliveryDao.listCustDelivery(paramMap);
	}
	
	/** 목록 카운트 조회 */
	public int countCustDelivery(Map<String, Object> paramMap) throws Exception {
		int totalCount = custDeliveryDao.countCustDelivery(paramMap);
		return totalCount;
	}
	
	/** 상세 조회 */
	public CustDeliveryModel selectCustDelivery(Map<String, Object> paramMap) throws Exception {
		CustDeliveryModel custDeliveryModel = custDeliveryDao.selectCustDelivery(paramMap);
		return custDeliveryModel;
	}

}
