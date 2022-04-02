package com.nexacro.sample.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import com.nexacro.sample.service.GoodsMgrService;
import com.nexacro.sample.service.impl.ibatis.GoodsMgrDAO;
import com.nexacro.sample.vo.GoodsMgrVO;
import com.nexacro.uiadapter17.spring.core.data.DataSetRowTypeAccessor;
import com.nexacro17.xapi.data.DataSet;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("goodsMgrService")
public class GoodsMgrServiceImpl extends EgovAbstractServiceImpl implements GoodsMgrService{

	private Logger logger = LoggerFactory.getLogger(UiAdapterSampleServiceImpl.class);

	@Resource(name = "goodsMgrDAO")
	private GoodsMgrDAO goodsMgrDAO;
	
	@Override
	public List<Map<String, Object>> GoodsList(Map<String, Object> searchMap) {
		// TODO Auto-generated method stub
		return goodsMgrDAO.selectGoodsInfo(searchMap);
	}

	@Override
	public void GoodsListInsert(Map<String, Object> insertInfo) {
		// TODO Auto-generated method stub
		goodsMgrDAO.GoodsListInsert(insertInfo);
	}

	@Override
	public void GoodsListUpdate(Map<String, Object> updateInfo) {
		// TODO Auto-generated method stub
		goodsMgrDAO.GoodsListUpdate(updateInfo);
		
	}

	@Override
	public void GoodsListDelete(Map<String, Object> deleteInfo) {
		// TODO Auto-generated method stub
		goodsMgrDAO.GoodsListDelete(deleteInfo);
		
	}

	@Override
	public List<Map<String, Object>> initGoodsCbo() {
		// TODO Auto-generated method stub
		return goodsMgrDAO.initGoodsCbo();
	}

	@Override
	public List<Map<String, Object>> initGoodsDetailCbo(String goods_category) {
		// TODO Auto-generated method stub
		return goodsMgrDAO.initGoodsDetailCbo(goods_category);
	}

}
