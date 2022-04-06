package kr.happyjob.study.scm.supplier.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.supplier.dao.SupplyManageDao;
import kr.happyjob.study.scm.supplier.model.ImpSales;
import kr.happyjob.study.scm.supplier.model.PageInfo;

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
	public PageInfo getSuppliers(PageInfo info) {
		
		supplyDao=sst.getMapper(SupplyManageDao.class);
		
		info.setTotalCount(supplyDao.getTotalCount(info));
		
		int selectPage=info.getSelectPage();
		int rowsPerPage=info.getRowsPerPage();
		int total=info.getTotalCount();
		
		int totalPage=total/rowsPerPage;
		totalPage=total%rowsPerPage>0? totalPage+1 : totalPage;
		
		selectPage=selectPage>totalPage? totalPage : selectPage;
		
		int firstIndex=total==0?0:rowsPerPage*(selectPage-1);
		
		
		info.setSelectPage(selectPage);
		
		
		
//		info.setFirstIndex(info.getRowsPerPage()*(info.getSelectPage()-1));
		info.setFirstIndex(firstIndex);
		info.setSuppliers(supplyDao.getSuppliers(info));
		
		return info;
	}

	@Override
	public List<ImpSales> getImpSales(String comp_id) {		
		return sst.getMapper(SupplyManageDao.class).getImpSales(comp_id);
	}
	
	

}
