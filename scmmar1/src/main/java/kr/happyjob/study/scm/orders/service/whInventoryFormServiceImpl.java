package kr.happyjob.study.scm.orders.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.orders.dao.whInventoryFormDao;
import kr.happyjob.study.scm.orders.model.whInventoryFormModel;
import kr.happyjob.study.scm.orders.model.whcntModel;

@Service
public class whInventoryFormServiceImpl implements whInventoryFormService {

	@Autowired
	whInventoryFormDao whinventoryformdao;
	
	@Override
	public List<whInventoryFormModel> whlist(Map<String, Object> paramMap) throws Exception {
		List<whInventoryFormModel> whlist = whinventoryformdao.whlist(paramMap);
		return whlist;
	}

	@Override
	public List<whcntModel> getStockState(String idx) throws Exception {
		List<whcntModel> detail = whinventoryformdao.getStockState(idx);
		return detail;
	}
	
	@Override
	public int total(Map<String, Object> paramMap) throws Exception {
		return whinventoryformdao.total(paramMap);
	}
	
}
