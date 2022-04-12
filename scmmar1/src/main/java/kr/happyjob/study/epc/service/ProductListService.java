package kr.happyjob.study.epc.service;

import java.util.ArrayList;
import java.util.HashMap;

import kr.happyjob.study.epc.model.SalesModel;
import kr.happyjob.study.epc.model.SearchParamDTO;

public interface ProductListService {

	abstract ArrayList<SalesModel> getListProduct(SearchParamDTO param);
	abstract SalesModel getProductDetail(int num);
	abstract ArrayList<String> getSalesTypeList();
	abstract ArrayList<String> getMfcompListBySalesType(String salesType);
	abstract Integer orderAndCartProduct(HashMap<String, String> params);
	public abstract int getListProductCnt(SearchParamDTO param);
	
}
