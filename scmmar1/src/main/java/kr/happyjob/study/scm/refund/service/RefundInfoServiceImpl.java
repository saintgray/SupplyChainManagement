package kr.happyjob.study.scm.refund.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.entity.PurchaseInfo;
import kr.happyjob.study.scm.refund.dao.RefundInfoDao;
import kr.happyjob.study.scm.refund.model.RefundInfoModel;

@Service
public class RefundInfoServiceImpl implements RefundInfoService {

	@Autowired
	RefundInfoDao refundinfodao;
	
	@Override
	public List<PurchaseInfo> getRefundInfoList(Map<String, Object> paramMap) throws Exception {
		List<PurchaseInfo> reinfolist = refundinfodao.refundInfoList(paramMap);
		return reinfolist;
		
	}

	@Override
	public int total(Map<String, Object> paramMap) throws Exception {
		int total = refundinfodao.total(paramMap);
		return total;
	}

	@Override
	public RefundInfoModel onereinfo(Map<String, Object> paramMap) throws Exception {
		RefundInfoModel onereinfo = refundinfodao.onereinfo(paramMap);
		return onereinfo;
	}

	@Override
	public int refupdate(Map<String, Object> paramMap) throws Exception {
		return refundinfodao.refupdate(paramMap);
	}

	
	
	
	
}
