package kr.happyjob.study.scm.sales.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.sales.model.PageInfo;
import kr.happyjob.study.scm.sales.model.SalesDetails;
import kr.happyjob.study.scm.sales.model.SalesRegData;

@Service
public interface SalesManageService {
	
	PageInfo getSalesList(PageInfo info);
	
	
	int insertSales(SalesRegData data, HttpServletRequest req) throws Exception;
	
	int deleteSales(String idx) throws Exception;
	
	SalesDetails getSalesDetails(String sales_id);
	
	int updateSales(SalesRegData data, HttpServletRequest req) throws Exception;
	
	List<String> selectAllPurchaseInfoByIdx(String pur_idx,String userType) throws Exception;

}
