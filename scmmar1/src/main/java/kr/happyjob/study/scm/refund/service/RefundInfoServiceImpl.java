package kr.happyjob.study.scm.refund.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.entity.PurchaseInfo;
import kr.happyjob.study.entity.RefundInfo;
import kr.happyjob.study.scm.refund.dao.RefundInfoDao;

@Service
public class RefundInfoServiceImpl implements RefundInfoService {

	@Autowired
	RefundInfoDao refundInfoDao;
	
	@Override
	public List<PurchaseInfo> getRefundInfoList(Map<String, Object> paramMap) throws Exception {
		List<PurchaseInfo> reinfolist = refundInfoDao.refundInfoList(paramMap);
		return reinfolist;
		
	}

	@Override
	public int total(Map<String, Object> paramMap) throws Exception {
		int total = refundInfoDao.total(paramMap);
		return total;
	}

	@Override
	public RefundInfo oneRefundInfo(Map<String, Object> paramMap) throws Exception {
		RefundInfo onereinfo = refundInfoDao.getRefundInfo(paramMap);
		return onereinfo;
	}

	@Override
	public int refupdate(Map<String, Object> paramMap) throws Exception {
		return refundInfoDao.refupdate(paramMap);
	}

	
	
	
	
}
