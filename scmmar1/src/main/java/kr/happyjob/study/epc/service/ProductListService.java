package kr.happyjob.study.epc.service;

import java.util.ArrayList;
import java.util.HashMap;

import kr.happyjob.study.epc.model.SalesModel;

public interface ProductListService {

	abstract ArrayList<SalesModel> getListProduct();
	abstract SalesModel getProductDetail(int num);
	abstract ArrayList<String> getSalesTypeList();
	abstract ArrayList<String> getMfcompListBySalesType(String salesType);
	abstract ArrayList<SalesModel> searchProductList(HashMap<String, String> params);
	abstract Integer orderAndCartProduct(HashMap<String, String> params);
	
	
}
