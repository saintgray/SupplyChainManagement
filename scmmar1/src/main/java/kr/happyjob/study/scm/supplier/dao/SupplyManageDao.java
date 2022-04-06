package kr.happyjob.study.scm.supplier.dao;

import java.util.List;

import kr.happyjob.study.scm.supplier.model.ImpSales;
import kr.happyjob.study.scm.supplier.model.PageInfo;
import kr.happyjob.study.scm.supplier.model.Supplier;

public interface SupplyManageDao {
	
	List<Supplier> getSuppliers(PageInfo info);
	List<ImpSales> getImpSales(String comp_id);
	int getTotalCount(PageInfo info);


}
