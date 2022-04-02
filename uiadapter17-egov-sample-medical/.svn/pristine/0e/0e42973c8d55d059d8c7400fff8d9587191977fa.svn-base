package com.nexacro.sample.service.impl.ibatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.nexacro.spring.dao.ibatis.NexacroIbatisAbstractDAO;

/**
 * <pre>
 * 
 * @title
 * @desc Food Order 처리를 한다. 
 * @package com.nexacro.Login.web
 * 
 *          <pre>
 * @author 김준서
 * @since 2020. 6. 10.
 * @version 1.0
 * @see =================== 변경 내역 ================== 날짜 변경자 내용
 *      ------------------------------------------------ 2020. 6. 10. 김준서 최초작성
 */

@Repository("orderDAO")
public class OrderDAO extends NexacroIbatisAbstractDAO {

	// goods-list select
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectGoodsMap(Map<String, Object> goodsMap) {
		return (List<Map<String, Object>>) list("Order.selectGoodsMapList", goodsMap);
	}
	
	public int checkSaleCnt(){
		return (int) select("Order.checkSaleCnt");
	}
	
	// order-list insert
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> insertOrderMap(Map<String, Object> orderMap) {
		return (List<Map<String, Object>>) insert ("Order.insertOrderMap", orderMap);
	}
	
	// goods-code check
	public void updateGoodsCnt(Map<String, Object> orderMap){
		update ("Order.updateGoodsCnt", orderMap);
	}
	
}

