package kr.happyjob.study.crtOrder.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.crtOrder.dao.CrtCartDao;
import kr.happyjob.study.crtOrder.dao.CrtOrderDao;
import kr.happyjob.study.crtOrder.model.CrtCartModel;
import kr.happyjob.study.crtOrder.model.CrtOrderModel;


@Service
public class CrtCartServiceImpl implements CrtCartService {

	@Autowired
	CrtCartDao crtCartDao;
	
	@Override
	public List<CrtCartModel> cartInfoList(Map<String, Object> paramMap) {
		return crtCartDao.cartInfoList(paramMap);
	}

	@Override
	public int saveCartOrder(Map<String, Object> paramMap) {
		return crtCartDao.saveCartOrder(paramMap);
	}

	@Override
	public int saveCartOrderDetail(Map<String, Object> paramMap) {
		
		int result =  crtCartDao.saveCartOrderDetail(paramMap);
		if(result>0){
			crtCartDao.insertCartOrderDelivery();	
		}
		
		return result;
	}

	@Override
	public int deleteCart(int cartno) {
		return crtCartDao.deleteCart(cartno);
	}

	

}
