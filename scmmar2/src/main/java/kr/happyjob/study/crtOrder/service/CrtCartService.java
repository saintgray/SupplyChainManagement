package kr.happyjob.study.crtOrder.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.crtOrder.model.CrtCartModel;

public interface CrtCartService {

	List<CrtCartModel> cartInfoList(Map<String, Object> paramMap);

	int saveCartOrder(Map<String, Object> paramMap);

	int saveCartOrderDetail(Map<String, Object> paramMap);

	int deleteCart(int cartno);

	


}
