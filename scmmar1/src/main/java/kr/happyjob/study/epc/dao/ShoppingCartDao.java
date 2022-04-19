package kr.happyjob.study.epc.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import kr.happyjob.study.epc.model.SearchParamDTO;
import kr.happyjob.study.epc.model.ShoppingCartItemDTO;

public interface ShoppingCartDao {

	public abstract ArrayList<ShoppingCartItemDTO> getCartList(SearchParamDTO loginID);
	public abstract int deleteCartItem(HashMap<String, String> params);
	public abstract int orderProductPurchase(Map<String, Object> paramMap);
	public abstract int orderProductPurchaseinfo(ShoppingCartItemDTO param);
	public abstract int updateCartItemPurYN(ShoppingCartItemDTO param);
	public abstract int getCartListTotalCount(String loginID);
}
