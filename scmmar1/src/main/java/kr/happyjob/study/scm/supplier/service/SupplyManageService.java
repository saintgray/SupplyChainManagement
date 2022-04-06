package kr.happyjob.study.scm.supplier.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.supplier.model.ImpSales;
import kr.happyjob.study.scm.supplier.model.PageInfo;
import kr.happyjob.study.scm.supplier.model.Supplier;

@Service
public interface SupplyManageService {
	
	PageInfo getSuppliers(PageInfo info);
	List<ImpSales> getImpSales(String comp_id);

}
