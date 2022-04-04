package kr.happyjob.study.scm.sales.dao;

import java.util.List;

import kr.happyjob.study.scm.model.FileModel;
import kr.happyjob.study.scm.sales.model.PageInfo;
import kr.happyjob.study.scm.sales.model.Sales;
import kr.happyjob.study.scm.sales.model.SalesDetails;
import kr.happyjob.study.scm.sales.model.SalesRegData;

public interface SalesManageDao {
	
	
	
	List<Sales> getSalesList(PageInfo info);
	int getTotalCount(PageInfo info);
	int insertSales(SalesRegData sales);
	int insertFiles(List<FileModel> files);
	int deleteSales(String idx);
	int updateSales(SalesRegData data);
	SalesDetails getSalesDetails(String sales_id);
	List<FileModel> getFilesBySalesID(String sales_id);
	int deleteFiles(List<FileModel> files);
	

}
