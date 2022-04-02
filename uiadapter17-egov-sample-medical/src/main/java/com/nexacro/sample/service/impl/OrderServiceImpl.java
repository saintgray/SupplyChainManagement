package com.nexacro.sample.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.hsqldb.lib.HashMap;
import org.springframework.stereotype.Service;

import com.nexacro.sample.service.OrderService;
import com.nexacro.sample.service.impl.ibatis.OrderDAO;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 
 * <pre>
 * 
 * @desc 공통코드.
 * @package com.nexacro.sample.service
 * 
 *          <pre>
 * 
 * @author 김준서
 * @since 2020. 6. 10.
 * @version 1.0
 * @see =================== 변경 내역 ================== 날짜 변경자 내용
 *      ------------------------------------------------
 * 
 */
@Service("orderService")
public class OrderServiceImpl extends EgovAbstractServiceImpl implements OrderService {

	@Resource(name = "orderDAO")
	private OrderDAO orderDAO; 
	
	@Override
	public List<Map<String, Object>> selectGoodsMap(Map<String, Object> goodsMap) {

		return orderDAO.selectGoodsMap(goodsMap);
	}
	
	@Override
	public void insertOrderMap(List<Map<String, Object>> orderMap) {
		int cnt = orderDAO.checkSaleCnt()+1;
		String sales_code = Integer.toString(cnt);
		int sale_totp=0;
		
		for(int i=0; i<orderMap.size(); i++){
			Map<String, Object> orderData = orderMap.get(i);
			int sale_p =(int)orderData.get("sale_p");
			sale_totp += sale_p;
		}
		for(int i=0; i<orderMap.size(); i++){
			Map<String, Object> orderData = orderMap.get(i);
			orderData.put("sales_code", sales_code);
			orderData.put("sale_totp", sale_totp);
			orderDAO.insertOrderMap(orderData);
			orderDAO.updateGoodsCnt(orderData);
		}
	}
}
