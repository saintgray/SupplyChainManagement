package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.dao.refundInsDao;
import kr.happyjob.study.scm.model.refundInsModel;

@Service
public class refundInsServiceImpl implements refundInsService {

	@Autowired
	refundInsDao refundinsdao;
	
	@Override
	public List<refundInsModel> relist(Map<String, Object> paramMap) throws Exception {
		List<refundInsModel> relist = refundinsdao.relist(paramMap);
		return relist;
	}

	@Override
	public int total(Map<String, Object> paramMap) throws Exception {
		int total = refundinsdao.total(paramMap);
		return total;
	}

	
	
	
	
	
	
	
}
