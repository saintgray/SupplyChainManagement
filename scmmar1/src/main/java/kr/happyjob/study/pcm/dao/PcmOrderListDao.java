package kr.happyjob.study.pcm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.pcm.model.PcmOrderListModel;

public interface PcmOrderListDao {

	public List<PcmOrderListModel> listPurchaseOrder(Map<String, Object> paramMap);

	public int totalCount(Map<String, Object> paramMap);

	public PcmOrderListModel pcmOrderOne(Map<String, Object> paramMap);

}
