
package kr.happyjob.study.ged.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.ged.dao.RefundConfirmDao;
import kr.happyjob.study.ged.model.RefundConfirmModel;

	@Service
	public class RefundConfirmServiceImpl implements RefundConfirmService{
		
		@Autowired
		RefundConfirmDao refundConfirmDao;


		@Override
		public List<RefundConfirmModel> refundConfirmList(Map<String, Object> paramMap) throws Exception {
			
			List<RefundConfirmModel> returnConfirmList = refundConfirmDao.refundConfirmList(paramMap);
			return returnConfirmList;
		}

		@Override
		public int refundConfirmCnt(Map<String, Object> paramMap) throws Exception {
			
			int refundConfirmCnt = refundConfirmDao.refundConfirmCnt(paramMap);
			return refundConfirmCnt;
		}

		@Override
		public void updaterefundConfirm(Map<String, Object> paramMap) throws Exception {
			refundConfirmDao.updaterefundConfirm(paramMap);
			
		}

	}
