package kr.happyjob.study.shipping.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.shipping.dao.ShippingDao;
import kr.happyjob.study.shipping.model.ShippingModel;

@Service
public class ShippingServiceImpl implements ShippingService{

	@Autowired
	ShippingDao shippingDao;
	
	/** 배송지시서 목록 조회 */
	@Override
	public List<ShippingModel> listDeliOrder(Map<String, Object> paramMap) throws Exception {
		List<ShippingModel> listDeliOrder = shippingDao.listDeliOrder(paramMap);
		return listDeliOrder;
	}

	/** 배송지시서 목록 카운트 조회 */
	@Override
	public int countListDeliOrder(Map<String, Object> paramMap) throws Exception {
		int totalCount = shippingDao.countListDeliOrder(paramMap);
		return totalCount;
	}
	
	/** 배송지시서 단건 상세 조회 selectOne */
	@Override
	public ShippingModel selectDeliOrder(Map<String, Object> paramMap) throws Exception {
		ShippingModel shippingModel = shippingDao.selectDeliOrder(paramMap);
		return shippingModel;
	}

	/** 배송지시서 배송상태 변경 */
	@Override
	public int updateDeliOrder(Map<String, Object> paramMap) throws Exception {
		int ret = shippingDao.updateDeliOrder(paramMap);
		return ret;
	}
	
	/**창고 수량 감소*/
	@Override
	public int updateStockReduce(Map<String, Object> paramMap) throws Exception {
		int ret = shippingDao.updateStockReduce(paramMap);
		return ret;
	}
	
	/**재고입출내역 insert*/
	public int insertDeparturehis(Map<String, Object> paramMap) throws Exception {
		int ret = shippingDao.insertDeparturehis(paramMap);
		return ret;
	}
	

	/** 타임스탬프 테스트 */
	@Override
	public String testSelect() throws Exception {
		return shippingDao.testSelect();
	}
	
	
}
