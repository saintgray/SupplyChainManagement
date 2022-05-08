package kr.happyjob.study.shipping.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.shipping.dao.PurchaseorderDAO;
import kr.happyjob.study.shipping.dao.RefundDao;
import kr.happyjob.study.shipping.model.PurchaseorderModel;

@Service
public class PurchaseorderServiceImpl implements PurchaseorderService{
	
	@Autowired
	PurchaseorderDAO purchaseDao;
	
	
	@Override
	public List<PurchaseorderModel> ListPurchaseOrder(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return purchaseDao.ListPurchaseOrder(paramMap);
	}
	
	@Override
	public int countListPurchaseOrder(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return purchaseDao.countListPurchaseOrder(paramMap);
	}
	
	
	@Override
	public PurchaseorderModel selectPurchaseOrder(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return purchaseDao.selectPurchaseOrder(paramMap);
	}
}	
