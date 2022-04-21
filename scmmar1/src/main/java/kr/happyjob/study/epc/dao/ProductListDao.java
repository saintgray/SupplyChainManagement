package kr.happyjob.study.epc.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.happyjob.study.epc.model.SalesModel;
import kr.happyjob.study.epc.model.SearchParamDTO;
import kr.happyjob.study.epc.model.ShoppingCartItemDTO;

public interface ProductListDao {

	
	public abstract List<SalesModel> getListProduct(SearchParamDTO param);
	public abstract SalesModel getProductDetail(int num);
	public abstract List<String> getSalesTypeList();
	public abstract List<String> getMfcompListBySalesType(Map<String, String> salesType);
	public abstract int addProductToCart(ShoppingCartItemDTO params);
	public abstract int orderProductPurchase(ShoppingCartItemDTO param);
	public abstract int orderProductPurchaseinfo(ShoppingCartItemDTO params);
	public abstract int getListProductCnt(SearchParamDTO param);
	public abstract List<ShoppingCartItemDTO> getCartItems(Map<String, Object> param);
	public abstract int updateCartItemCnt(ShoppingCartItemDTO params);
	
	
}
