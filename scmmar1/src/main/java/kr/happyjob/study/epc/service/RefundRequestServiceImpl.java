package kr.happyjob.study.epc.service;

import java.util.List;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.epc.dao.RefundRequestDao;
import kr.happyjob.study.epc.model.OrderListItemDTO;
import kr.happyjob.study.epc.model.RefundinfoDTO;
import kr.happyjob.study.epc.model.SearchParamDTO;

@Service
public class RefundRequestServiceImpl implements RefundRequestService {

	@Autowired
	RefundRequestDao rrdao;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
		
		
		
	public List<OrderListItemDTO> getOrderList(SearchParamDTO param){
		
		List<OrderListItemDTO> result = rrdao.getOrderList(param);
		
		return result;
	}
	
	public List<OrderListItemDTO> getOrderDetailList(SearchParamDTO param) {
		
		List<OrderListItemDTO> result = rrdao.getOrderDetailList(param);
		
		return result;
	}
	
	public int insertRefundinfo(RefundinfoDTO param) {
		logger.info(param.getCheckedPurinfIdList());
		logger.info(param.getCheckedReturnCntList());
		
		for(int i =0; i < param.getCheckedPurinfIdList().size(); i++) {
			param.setPurinf_id(param.getCheckedPurinfIdList().get(i));
			param.setReturn_cnt(param.getCheckedReturnCntList().get(i));
			rrdao.insertRefundinfo(param);
			logger.info(param);
		}
	
		
		return 1;
	}
	
	
	public List<String> getBankNameList() {
		
		List<String> result = rrdao.getBankNameList();
		return result;
	}
	
	public int getTotalOrderListCnt(SearchParamDTO param) {
		
		return rrdao.getTotalOrderListCnt(param);
	}
	
	public int getTotalOrderDetailListCnt(int purID) {
		return rrdao.getTotalOrderDetailListCnt(purID);
	}
	
	public int deleteRefundinfoByPurinfID(int purinf_id) {
		int result = 0;
		int a = updatePurinfReturnYNtoY(purinf_id);
		int b = rrdao.deleteRefundinfoByPurinfID(purinf_id);
		if(a==1 && b==1) {
			result =1;
		}
		return result;
	}
	
	private int updatePurinfReturnYNtoY(int purinf_id) {
		
		return rrdao.updatePurinfReturnYNtoY(purinf_id);
	}
}
