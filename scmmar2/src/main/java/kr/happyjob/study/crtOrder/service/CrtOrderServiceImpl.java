package kr.happyjob.study.crtOrder.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.crtOrder.dao.CrtOrderDao;
import kr.happyjob.study.crtOrder.model.CrtOrderModel;


@Service
public class CrtOrderServiceImpl implements CrtOrderService {

	@Autowired
	CrtOrderDao crtOrderDao;
	
	
	
	@Override
	public List<CrtOrderModel> listProduct(Map<String, Object> paramMap) {
		List<CrtOrderModel> list = crtOrderDao.listProduct(paramMap);
		return list;
	}

	@Override
	public int countlistProduct(Map<String, Object> paramMap) {
		int count = crtOrderDao.countlistProduct(paramMap);
		return count;
	}

	@Override
	public List<CrtOrderModel> categoryBoxList() {
		return crtOrderDao.categoryBoxList();
	}

	@Override
	public List<CrtOrderModel> pdmdcopBoxList(Map<String, Object> paramMap) {
		return crtOrderDao.pdmdcopBoxList(paramMap);
	}

	@Override
	public CrtOrderModel selectProductOne(Map<String, Object> paramMap) {
		return crtOrderDao.selectProductOne(paramMap);
	}

	@Override
	public void insertCartProduct(Map<String, Object> paramMap) {
		crtOrderDao.insertCartProduct(paramMap);
		
	}

	@Override
	public void insertOrderProduct(Map<String, Object> paramMap) {
		int result = crtOrderDao.insertOrderProduct(paramMap);
		if(result>0){
			int resultDetail =  crtOrderDao.insertOrderProductDetail(paramMap);
				if(resultDetail>0){
					crtOrderDao.insertOrderDelivery();	
				}
		}
		
	}


	
	
}
