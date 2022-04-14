package kr.happyjob.study.epc.dao;

import java.util.ArrayList;
import java.util.HashMap;

import kr.happyjob.study.epc.model.SalesModel;
import kr.happyjob.study.epc.model.SearchParamDTO;
import kr.happyjob.study.epc.model.ShoppingCartItemDTO;

public interface ProductListDao {

	
	public abstract ArrayList<SalesModel> getListProduct(SearchParamDTO param);
	public abstract SalesModel getProductDetail(int num);
	public abstract ArrayList<String> getSalesTypeList();
	public abstract ArrayList<String> getMfcompListBySalesType(HashMap<String, String> salesType);
	public abstract Integer addProductToCart(ShoppingCartItemDTO params);
	public abstract Integer orderProductPurchase(ShoppingCartItemDTO param);
	public abstract Integer orderProductPurchaseinfo(ShoppingCartItemDTO params);
	public abstract int getListProductCnt(SearchParamDTO param);
	public abstract ArrayList<ShoppingCartItemDTO> getCartItems(HashMap<String,Object> param);
	public abstract Integer updateCartItemCnt(ShoppingCartItemDTO params);
	
	
}
