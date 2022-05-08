package kr.happyjob.study.epc.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.epc.model.SearchParamDTO;
import kr.happyjob.study.epc.model.ShoppingCartItemDTO;

public interface ShoppingCartService {

	public abstract List<ShoppingCartItemDTO> getCartList(SearchParamDTO param);
	public abstract int deleteCartItem(Map<String, String> params);
	public abstract int orderProducts(String data, String loginID,String userType) throws Exception;
	public abstract int getCartListTotalCount(String loginID);
	public abstract int orderProductsVue(String data, String loginID,String userType) throws Exception;
	
	
}
