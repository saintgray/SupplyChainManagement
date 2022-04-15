package kr.happyjob.study.scmTask.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scmTask.dao.PaybackOrderDao;
import kr.happyjob.study.scmTask.model.PaybackOrderModel;

@Service
public class PaybackOrderServiceImpl implements PaybackOrderService{
	
	
	// Set logger
		private final Logger logger = LogManager.getLogger(this.getClass());
		
		// Get class name for logger
		private final String className = this.getClass().toString();
		
		@Autowired
		PaybackOrderDao paybackOrderDao;
		
		/** 고객정보 목록 조회 */
		public List<PaybackOrderModel> listPaybackOrder(Map<String, Object> paramMap) throws Exception {
			
			List<PaybackOrderModel> listPaybackOrder = paybackOrderDao.listPaybackOrder(paramMap);
			
			return listPaybackOrder;
		}
		
		/** 고객정보 목록 카운트 조회 */
		public int countListPaybackOrder(Map<String, Object> paramMap) throws Exception {
			
			int totalCount = paybackOrderDao.countListPaybackOrder(paramMap);
			
			return totalCount;
		}
		
		
		/* 반품승인여부 업데이트 */
		public int updateOdryn(PaybackOrderModel paybackOrderModel) throws Exception{
			
			return paybackOrderDao.updateOdryn(paybackOrderModel);
			
		}

}
