package kr.happyjob.study.scm.orders.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.orders.dao.purchaseDirDao;
import kr.happyjob.study.scm.orders.model.purchaseDirModel;

@Service
public class purchaseDirServiceImpl implements purchaseDirService {

	@Autowired
	purchaseDirDao purchasedirdao;

	@Override
	public List<purchaseDirModel> listpurchaseDir(Map<String, Object> paramMap) throws Exception {
		List<purchaseDirModel> listpurchaseDir = purchasedirdao.listpurchaseDir(paramMap);
		return listpurchaseDir;
	}
	@Override
	public int total(Map<String, Object> paramMap) throws Exception {
		return purchasedirdao.total(paramMap);
	}
	

	
	
	
	
	
	
	
}
