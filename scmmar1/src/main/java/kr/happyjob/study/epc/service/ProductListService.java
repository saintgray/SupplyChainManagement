package kr.happyjob.study.epc.service;

import java.util.List;

import kr.happyjob.study.epc.model.SalesModel;
import kr.happyjob.study.epc.model.SearchParamDTO;
import kr.happyjob.study.epc.model.ShoppingCartItemDTO;

public interface ProductListService {

	public abstract List<SalesModel> getListProduct(SearchParamDTO param);
	public abstract SalesModel getProductDetail(int num);
	public abstract List<String> getSalesTypeList();
	public abstract List<String> getMfcompListBySalesType(String salesType);
	public abstract int orderAndCartProduct(ShoppingCartItemDTO params);
	public abstract int getListProductCnt(SearchParamDTO param);
	
}
