package kr.happyjob.study.pcm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.pcm.dao.PcmOrderListDao;
import kr.happyjob.study.pcm.model.PcmOrderListModel;

@Service
public class PcmOrderListServiceImpl implements PcmOrderListService {

	@Autowired
	PcmOrderListDao pcmOrderListDao;
	
	/** 발주내역 목록 조회 */
	public List<PcmOrderListModel> listPurchaseOrder(Map<String, Object> paramMap) throws Exception {
		
		List<PcmOrderListModel> listPurchaseOrder = pcmOrderListDao.listPurchaseOrder(paramMap);
		
		return listPurchaseOrder;
	}

	@Override
	public int totalCount(Map<String, Object> paramMap) throws Exception {
		
		int totalCount = pcmOrderListDao.totalCount(paramMap);
		
		return totalCount;
	}

	@Override
	public PcmOrderListModel pcmOrderOne(Map<String, Object> paramMap) throws Exception {
		
		PcmOrderListModel pcmOrderListModel = pcmOrderListDao.pcmOrderOne(paramMap);
		
		return pcmOrderListModel;
	}

}
