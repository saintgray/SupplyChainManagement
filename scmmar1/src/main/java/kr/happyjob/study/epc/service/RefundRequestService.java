package kr.happyjob.study.epc.service;

import java.util.List;

import kr.happyjob.study.epc.model.OrderListItemDTO;
import kr.happyjob.study.epc.model.RefundinfoDTO;
import kr.happyjob.study.epc.model.SearchParamDTO;

public interface RefundRequestService {

	public abstract List<OrderListItemDTO> getOrderList(SearchParamDTO param);
	public abstract List<OrderListItemDTO> getOrderDetailList(SearchParamDTO param);
	public abstract int insertRefundinfo(RefundinfoDTO param);
	public abstract List<String> getBankNameList();
	public abstract int getTotalOrderListCnt(SearchParamDTO param);
	public abstract int getTotalOrderDetailListCnt(int purID);
	public abstract int deleteRefundinfoByPurinfID(int purinf_id);
}
