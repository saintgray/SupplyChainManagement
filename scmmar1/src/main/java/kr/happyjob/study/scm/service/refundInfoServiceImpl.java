package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.dao.refundInfoDao;
import kr.happyjob.study.scm.model.refundInfoModel;

@Service
public class refundInfoServiceImpl implements refundInfoService {

	@Autowired
	refundInfoDao refundinfodao;
	
	@Override
	public List<refundInfoModel> reinfolist(Map<String, Object> paramMap) throws Exception {
		List<refundInfoModel> reinfolist = refundinfodao.reinfolist(paramMap);
		return reinfolist;
	}

	@Override
	public int total(Map<String, Object> paramMap) throws Exception {
		int total = refundinfodao.total(paramMap);
		return total;
	}

	@Override
	public refundInfoModel onereinfo(Map<String, Object> paramMap) throws Exception {
		refundInfoModel onereinfo = refundinfodao.onereinfo(paramMap);
		return onereinfo;
	}

	@Override
	public int refupdate(Map<String, Object> paramMap) throws Exception {
		return refundinfodao.refupdate(paramMap);
	}

	
	
	
	
	
	
	
}
