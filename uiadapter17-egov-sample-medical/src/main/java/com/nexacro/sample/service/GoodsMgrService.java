package com.nexacro.sample.service;

import java.util.List;
import java.util.Map;
import com.nexacro.sample.vo.GoodsMgrVO;

public interface GoodsMgrService {
	List<Map<String, Object>> GoodsList(Map<String, Object> searchMap);
	
	List<Map<String, Object>> initGoodsCbo();
	
	List<Map<String, Object>> initGoodsDetailCbo(String goods_category);

	void GoodsListInsert(Map<String, Object> insertInfo);

	void GoodsListUpdate(Map<String, Object> updateInfo);

	void GoodsListDelete(Map<String, Object> deleteInfo);
}
