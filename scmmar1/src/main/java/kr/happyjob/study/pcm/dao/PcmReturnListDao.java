package kr.happyjob.study.pcm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.pcm.model.PcmReturnListModel;

public interface PcmReturnListDao {

	
	public List<PcmReturnListModel> listPurchaseReturn(Map<String, Object> paramMap);

	public int totalCount(Map<String, Object> paramMap);

	public PcmReturnListModel pcmReturnOne(Map<String, Object> paramMap);

	
}
