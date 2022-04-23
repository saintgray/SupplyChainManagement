package kr.happyjob.study.scm.refund.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.refund.dao.RefundInsDao;
import kr.happyjob.study.scm.refund.model.RefundInsModel;

@Service
public class RefundInsServiceImpl implements RefundInsService {

	@Autowired
	RefundInsDao refundinsdao;
	
	@Override
	public List<RefundInsModel> relist(Map<String, Object> paramMap) throws Exception {
		List<RefundInsModel> relist = refundinsdao.relist(paramMap);
		return relist;
	}

	@Override
	public int total(Map<String, Object> paramMap) throws Exception {
		int total = refundinsdao.total(paramMap);
		return total;
	}

	
	
	
	
	
	
	
}
