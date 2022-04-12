package kr.happyjob.study.pcm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.pcm.dao.PcmReturnListDao;
import kr.happyjob.study.pcm.model.PcmReturnListModel;

@Service
public class PcmReturnListServiceImpl implements PcmReturnListService {

	@Autowired
	PcmReturnListDao returnPurchaseDao;
	
	public List<PcmReturnListModel> listPurchaseReturn(Map<String, Object> paramMap) throws Exception {
		
		List<PcmReturnListModel> listPurchaseReturn = returnPurchaseDao.listPurchaseReturn(paramMap);
		
		return listPurchaseReturn;
	}

	@Override
	public int totalCount(Map<String, Object> paramMap) throws Exception {
		
		int totalCount = returnPurchaseDao.totalCount(paramMap);
		
		return totalCount;
	}

	@Override
	public PcmReturnListModel pcmReturnOne(Map<String, Object> paramMap) throws Exception {
		
		PcmReturnListModel pcmReturnListModel =  returnPurchaseDao.pcmReturnOne(paramMap);
		
		
		return pcmReturnListModel;
	}

}
