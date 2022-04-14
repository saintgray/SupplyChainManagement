package kr.happyjob.study.shipping.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.shipping.dao.RefundDao;
import kr.happyjob.study.shipping.model.RefundModel;

@Service
public class RefundServiceImpl implements RefundService{

	@Autowired
	RefundDao refundDao;

	@Override
	public List<RefundModel> listRefund(Map<String, Object> paramMap) throws Exception {
		List<RefundModel> listRefund = refundDao.listRefund(paramMap);
		return listRefund; 
	}

	@Override
	public int countListRefund(Map<String, Object> paramMap) throws Exception {
		int totalCount = refundDao.countListRefund(paramMap);
		return totalCount;
	}
	
	
	
}
