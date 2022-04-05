package kr.happyjob.study.epc.dao;

import java.util.ArrayList;
import java.util.HashMap;

import kr.happyjob.study.epc.model.SalesModel;

public interface ProductListDao {

	
	abstract ArrayList<SalesModel> getListProduct();
	abstract SalesModel getProductDetail(int num);
	abstract ArrayList<String> getSalesTypeList();
	abstract ArrayList<String> getMfcompListBySalesType(HashMap<String, String> salesType);
	abstract ArrayList<SalesModel> searchProductList(HashMap<String, String> params);
	abstract Integer addProductToCart(HashMap<String, String> params);
	abstract Integer orderProductPurchase(HashMap<String, String> params);
	abstract Integer orderProductPurchaseinfo(HashMap<String, String> params);

	
	
}
