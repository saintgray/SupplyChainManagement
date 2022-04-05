package kr.happyjob.study.scm.supplier.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.supplier.dao.SupplyManageDao;
import kr.happyjob.study.scm.supplier.model.ImpSales;
import kr.happyjob.study.scm.supplier.model.PageInfo;
import kr.happyjob.study.scm.supplier.model.Supplier;

@Service
public class SupplyManageServiceImpl implements SupplyManageService {
	
	private SqlSessionTemplate sst;
	
	private SupplyManageDao supplyDao;
	
	public SupplyManageServiceImpl() {

	}
	
	
	@Autowired
	public SupplyManageServiceImpl(SqlSessionTemplate sst) {
		
		this.sst = sst;
	}



	@Override
	public List<Supplier> getSuppliers(PageInfo info) {
		
		return null;
	}

	@Override
	public List<ImpSales> getImpSales(String comp_id) {

		return null;
	}
	
	

}
