package kr.happyjob.study.crtOrder.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.crtOrder.model.CrtOrderModel;

public interface CrtOrderDao {

	public List<CrtOrderModel> listProduct(Map<String, Object> paramMap);

	public int countlistProduct(Map<String, Object> paramMap);

	public List<CrtOrderModel> categoryBoxList();

	public List<CrtOrderModel> pdmdcopBoxList(Map<String, Object> paramMap);

	public CrtOrderModel selectProductOne(Map<String, Object> paramMap);

	public void insertCartProduct(Map<String, Object> paramMap);

	public int insertOrderProduct(Map<String, Object> paramMap);

	public int insertOrderProductDetail(Map<String, Object> paramMap);

	public void insertOrderDelivery();

}
