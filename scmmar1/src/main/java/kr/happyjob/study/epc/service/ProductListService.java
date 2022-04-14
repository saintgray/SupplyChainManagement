package kr.happyjob.study.epc.service;

import java.util.ArrayList;
import java.util.HashMap;

import kr.happyjob.study.epc.model.SalesModel;
import kr.happyjob.study.epc.model.SearchParamDTO;
import kr.happyjob.study.epc.model.ShoppingCartItemDTO;

public interface ProductListService {

	public abstract ArrayList<SalesModel> getListProduct(SearchParamDTO param);
	public abstract SalesModel getProductDetail(int num);
	public abstract ArrayList<String> getSalesTypeList();
	public abstract ArrayList<String> getMfcompListBySalesType(String salesType);
	public abstract Integer orderAndCartProduct(ShoppingCartItemDTO params);
	public abstract int getListProductCnt(SearchParamDTO param);
	
}
