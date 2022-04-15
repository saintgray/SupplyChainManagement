package kr.happyjob.study.scmTask.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scmTask.dao.DeliveryDao;
import kr.happyjob.study.scmTask.model.DeliveryModel;
import kr.happyjob.study.system.model.ComnGrpCodModel;

@Service
public class DeliveryServiceImpl implements DeliveryService {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
		
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	DeliveryDao deliveryDao;

	/** 목록 조회 */
	public List<DeliveryModel> listDelivery(Map<String, Object> paramMap) throws Exception {
		List<DeliveryModel> listDelivery = deliveryDao.listDelivery(paramMap);
		return listDelivery;
	}

	/** 목록 카운트 조회 */
	public Integer countListDelivery(Map<String, Object> paramMap) throws Exception {
		Integer totalCount = deliveryDao.countListDelivery(paramMap);
		return totalCount;
	}

	/** 상세 조회 */
	public DeliveryModel selectDelivery(Map<String, Object> paramMap) throws Exception {
		DeliveryModel deliveryModel = deliveryDao.selectDelivery(paramMap);
		return deliveryModel;
	}

}
