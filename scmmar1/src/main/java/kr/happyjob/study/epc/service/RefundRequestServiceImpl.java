package kr.happyjob.study.epc.service;

import java.util.ArrayList;

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
		
		
		
	public ArrayList<OrderListItemDTO> getOrderList(SearchParamDTO param){
		
		ArrayList<OrderListItemDTO> result = rrdao.getOrderList(param);
		
		return result;
	}
	
	public ArrayList<OrderListItemDTO> getOrderDetailList(SearchParamDTO param) {
		
		ArrayList<OrderListItemDTO> result = rrdao.getOrderDetailList(param);
		
		return result;
	}
	
	public int insertRefundinfo(RefundinfoDTO param) {
		logger.info(param.getPurinf_id_list());
		
		param.getPurinf_id_list().forEach((item)->{
			param.setPurinf_id(item);
			rrdao.insertRefundinfo(param);
			logger.info(param);
		});
		
		return 1;
	}
	
	
	public ArrayList<String> getBankNameList() {
		
		ArrayList<String> result = rrdao.getBankNameList();
		return result;
	}
	
	public int getTotalOrderListCnt(SearchParamDTO param) {
		
		return rrdao.getTotalOrderListCnt(param);
	}
	
	public int getTotalOrderDetailListCnt(int purID) {
		return rrdao.getTotalOrderDetailListCnt(purID);
	}
}
