package kr.happyjob.study.crtOrder.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.crtOrder.model.CrtOrderModel;
import kr.happyjob.study.crtPayback.model.CrtOrderHistoryModel;

public interface CrtOrderService {

	List<CrtOrderModel> listProduct(Map<String, Object> paramMap);

	int countlistProduct(Map<String, Object> paramMap);

	List<CrtOrderModel> categoryBoxList();

	List<CrtOrderModel> pdmdcopBoxList(Map<String, Object> paramMap);

	CrtOrderModel selectProductOne(Map<String, Object> paramMap);

	void insertCartProduct(Map<String, Object> paramMap);

	void insertOrderProduct(Map<String, Object> paramMap);

}
