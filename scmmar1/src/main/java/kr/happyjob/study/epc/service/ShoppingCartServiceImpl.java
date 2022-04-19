package kr.happyjob.study.epc.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.epc.dao.ProductListDao;
import kr.happyjob.study.epc.dao.ShoppingCartDao;
import kr.happyjob.study.epc.model.SearchParamDTO;
import kr.happyjob.study.epc.model.ShoppingCartItemDTO;

@Service
public class ShoppingCartServiceImpl implements ShoppingCartService {

	@Autowired
	ShoppingCartDao scdao;

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	
	@Override
	public ArrayList<ShoppingCartItemDTO>getCartList(SearchParamDTO param) {
		ArrayList<ShoppingCartItemDTO> list = scdao.getCartList(param);  
		return list;
	};
	
	@Override
	public int deleteCartItem(HashMap<String, String> params) {
		int result = scdao.deleteCartItem(params);  
		return result;
	};
	
	@Override
	public int orderProducts(String data, String loginID, String userType) throws Exception {
		
		ArrayList<ShoppingCartItemDTO> params = new ArrayList<>();
		JSONParser parser = new JSONParser();
		JSONArray json;
		
		int result=0;
		
		try {
			
			Map<String, Object> paramMap=new HashMap<>();
			paramMap.put("loginID", loginID);
			paramMap.put("pur_id", null);
			paramMap.put("userType", userType);
			// useGenerateKey 사용해서 pur_id 에 PK 값 할당
			result=scdao.orderProductPurchase(paramMap);
			
			json = (JSONArray) parser.parse(data);
			json.forEach((item)->{
				JSONObject obj = (JSONObject) item;
				ShoppingCartItemDTO param = new ShoppingCartItemDTO();
				param.setPur_cnt(Integer.valueOf((String) obj.get("pur_cnt")));
				param.setWanted_date((String) obj.get("wanted_date"));
				param.setSales_id(Integer.valueOf((String) obj.get("sales_id")));
				param.setLoginID(loginID);
				
				// 주문 상세에 pur_id 값 왜 안넣었나?
				param.setPur_id(Integer.parseInt(paramMap.get("pur_id").toString()));
				
				
				/*pdao.orderProductPurchase(param);
				pdao.orderProductPurchaseinfo(param);*/
				params.add(param);
			});
			
		
		
		
		params.forEach((item)->{
			logger.info("scservice orderProducts");
			logger.info(item);
			scdao.orderProductPurchaseinfo(item);
			scdao.updateCartItemPurYN(item);
			
		});
		} catch (ParseException e) {
			e.printStackTrace();
			throw new Exception();
		}
		return result;
	}
	
	public int getCartListTotalCount(String loginID){
		return scdao.getCartListTotalCount(loginID);
		
	}
	
}
