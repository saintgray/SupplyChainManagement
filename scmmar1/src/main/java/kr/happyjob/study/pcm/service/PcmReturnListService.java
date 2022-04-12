package kr.happyjob.study.pcm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.pcm.model.PcmReturnListModel;

public interface PcmReturnListService {

	public List<PcmReturnListModel> listPurchaseReturn(Map<String, Object> paramMap)throws Exception;

	public int totalCount(Map<String, Object> paramMap)throws Exception;

	public PcmReturnListModel pcmReturnOne(Map<String, Object> paramMap) throws Exception;

}
