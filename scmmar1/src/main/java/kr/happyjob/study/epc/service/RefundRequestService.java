package kr.happyjob.study.epc.service;

import java.util.ArrayList;

import kr.happyjob.study.epc.model.OrderListItemDTO;
import kr.happyjob.study.epc.model.RefundinfoDTO;
import kr.happyjob.study.epc.model.SearchParamDTO;

public interface RefundRequestService {

	public abstract ArrayList<OrderListItemDTO> getOrderList(SearchParamDTO param);
	public abstract ArrayList<OrderListItemDTO> getOrderDetailList(SearchParamDTO param);
	public abstract int insertRefundinfo(RefundinfoDTO param);
	public abstract ArrayList<String> getBankNameList();
	public abstract int getTotalOrderListCnt(SearchParamDTO param);
	public abstract int getTotalOrderDetailListCnt(int purID);
	public abstract int deleteRefundinfoByPurinfID(int purinf_id);
}
