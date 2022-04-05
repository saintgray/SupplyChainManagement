package kr.happyjob.study.epc.dao;

import java.util.ArrayList;

import kr.happyjob.study.epc.model.ShoppingCartItemDTO;

public interface ShoppingCartDao {

	abstract ArrayList<ShoppingCartItemDTO> getCartList(String loginID);
	
}
