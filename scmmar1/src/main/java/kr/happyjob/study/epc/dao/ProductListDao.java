package kr.happyjob.study.epc.dao;

import java.util.ArrayList;
import java.util.HashMap;

import kr.happyjob.study.epc.model.SalesModel;
import kr.happyjob.study.epc.model.SearchParamDTO;

public interface ProductListDao {

	
	abstract ArrayList<SalesModel> getListProduct(SearchParamDTO param);
	abstract SalesModel getProductDetail(int num);
	abstract ArrayList<String> getSalesTypeList();
	abstract ArrayList<String> getMfcompListBySalesType(HashMap<String, String> salesType);
	abstract Integer addProductToCart(HashMap<String, String> params);
	abstract Integer orderProductPurchase(HashMap<String, String> params);
	abstract Integer orderProductPurchaseinfo(HashMap<String, String> params);
	public abstract int getListProductCnt(SearchParamDTO param);
	
	
}
