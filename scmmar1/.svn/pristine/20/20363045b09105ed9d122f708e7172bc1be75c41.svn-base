package kr.happyjob.study.ged.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.ged.dao.orderConfirmDao;
import kr.happyjob.study.ged.model.orderConfirmModel;

@Service
public class orderConfirmServiceImpl implements orderConfirmService{
	
	@Autowired
	orderConfirmDao orderConfirmDao;

	@Override
	public List<orderConfirmModel> orderConfirmList(Map<String, Object> paramMap) throws Exception {
		
		List<orderConfirmModel> orderConfirmList = orderConfirmDao.orderConfirmList(paramMap);
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
