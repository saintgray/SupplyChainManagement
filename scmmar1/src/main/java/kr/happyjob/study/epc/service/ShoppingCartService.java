package kr.happyjob.study.epc.service;

import java.util.ArrayList;

import kr.happyjob.study.epc.model.ShoppingCartItemDTO;

public interface ShoppingCartService {

	abstract ArrayList<ShoppingCartItemDTO> getCartList(String loginID);
}
