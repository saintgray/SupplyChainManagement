package com.nexacro.sample.service.impl.ibatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.nexacro.sample.vo.GoodsMgrVO;
import com.nexacro.spring.dao.ibatis.NexacroIbatisAbstractDAO;

/**
 * <pre>
 * @desc    음식류 관리
 * @package com.nexacro.sample.service.impl.ibatis
 * <pre>
 * 
 * @author  김기현
 * @since   2020. 06. 09.
 * @version 1.0
 * @see
 * =================== 변경 내역 ==================
 * 날짜			변경자		내용
 * ------------------------------------------------
 * 2020. 06. 09.	김기현	       최초작성
 */
@Repository("goodsMgrDAO")
public class GoodsMgrDAO extends NexacroIbatisAbstractDAO{
    //Map처리 추가 
    @SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectGoodsInfo(Map<String, Object> selectInfo) {   	
    	return (List<Map<String, Object>>) list("goodsMgr.selectGoodsInfo", selectInfo);
    }
    
    @SuppressWarnings("unchecked")
	public List<Map<String, Object>> initGoodsCbo() {   	
    	return (List<Map<String, Object>>) list("goodsMgr.initGoodsCbo");
    }
    
    @SuppressWarnings("unchecked")
	public List<Map<String, Object>> initGoodsDetailCbo(String goods_category) {   	
    	return (List<Map<String, Object>>) list("goodsMgr.initGoodsDetailCbo", goods_category);
    }
    
    @SuppressWarnings("unchecked")
	public void GoodsListUpdate(Map<String, Object> updateInfo) {   	
    	update("goodsMgr.goodsListUpdate",updateInfo);
    }
    
    @SuppressWarnings("unchecked")
	public void GoodsListDelete(Map<String, Object> deleteInfo) {   	
    	update("goodsMgr.goodsListDelete", deleteInfo);
    }
    
    @SuppressWarnings("unchecked")
	public void GoodsListInsert(Map<String, Object> insertInfo) {   	
    	insert("goodsMgr.goodsListInsert", insertInfo);
    }
}
