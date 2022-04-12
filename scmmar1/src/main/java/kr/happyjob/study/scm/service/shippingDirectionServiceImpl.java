package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.dao.shippingDirectionDao;
import kr.happyjob.study.scm.model.oneshipModel;
import kr.happyjob.study.scm.model.shippingDirectionModel;

@Service
public class shippingDirectionServiceImpl implements shippingDirectionService{

	@Autowired
	shippingDirectionDao shippingdirectiondao;
	
	@Override
	public List<shippingDirectionModel> listship(Map<String, Object> paramMap) throws Exception {
		List<shippingDirectionModel> listship = shippingdirectiondao.listship(paramMap);
		return listship;
	}
	
	@Override
	public int total(Map<String, Object> paramMap) throws Exception {
		return shippingdirectiondao.total(paramMap);
	}

	@Override
	public oneshipModel onesip(Map<String, Object> paramMap) throws Exception {
		oneshipModel onesip = shippingdirectiondao.onesip(paramMap);
		return onesip;
	}

	
	
	
	
	
	
	
}
