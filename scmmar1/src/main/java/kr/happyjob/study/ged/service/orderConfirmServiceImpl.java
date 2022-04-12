package kr.happyjob.study.ged.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.ged.dao.OrderConfirmDao;
import kr.happyjob.study.ged.model.OrderConfirmModel;

@Service
public class OrderConfirmServiceImpl implements OrderConfirmService{
	
	@Autowired
	OrderConfirmDao orderConfirmDao;

	@Override
	public List<OrderConfirmModel> orderConfirmList(Map<String, Object> paramMap) throws Exception {
		
		List<OrderConfirmModel> orderConfirmList = orderConfirmDao.orderConfirmList(paramMap);
		return orderConfirmList;
	}

	@Override
	public int orderConfirmCnt(Map<String, Object> paramMap) throws Exception {
		int orderConfirmCnt = orderConfirmDao.orderConfirmCnt(paramMap);
		return orderConfirmCnt;
	}

	@Override
	public void updateorderConfirm(Map<String, Object> paramMap) throws Exception {
		
		orderConfirmDao.updateorderConfirm(paramMap);
		
	}

}
