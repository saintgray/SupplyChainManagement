package kr.happyjob.study.epc.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.epc.dao.ShoppingCartDao;
import kr.happyjob.study.epc.model.ShoppingCartItemDTO;

@Service
public class ShoppingCartServiceImpl implements ShoppingCartService {

	@Autowired
	ShoppingCartDao scdao;
	
	public ArrayList<ShoppingCartItemDTO>getCartList(String loginID) {
		ArrayList<ShoppingCartItemDTO> list = scdao.getCartList(loginID);  
		return list;
	};
	
}
