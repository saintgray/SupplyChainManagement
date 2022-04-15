package kr.happyjob.study.crtOrder.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.crtOrder.model.CrtCartModel;
import kr.happyjob.study.crtOrder.model.CrtOrderModel;

public interface CrtCartDao {

	List<CrtCartModel> cartInfoList(Map<String, Object> paramMap);

	int saveCartOrder(Map<String, Object> paramMap);

	int saveCartOrderDetail(Map<String, Object> paramMap);

	int deleteCart(int cartno);

	void insertCartOrderDelivery();
	
}
