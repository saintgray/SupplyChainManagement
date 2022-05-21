package kr.happyjob.study.scm.supplier.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.supplier.dao.SupplyManageDao;
import kr.happyjob.study.scm.supplier.model.ImpSales;
import kr.happyjob.study.scm.supplier.model.PageInfo;
import kr.happyjob.study.scm.supplier.model.Supplier;
import kr.happyjob.study.system.model.ComnCodUtilModel;

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
		
		int selectPage=info.getSelectPage();
		int rowsPerPage=info.getRowsPerPage();

		int totalPage=info.getTotalPage();
		int total=supplyDao.getTotalCount(info);
		List<Supplier> suppliers=null;
		if(total>0){
			totalPage=total/rowsPerPage;
			totalPage=total%rowsPerPage>0? totalPage+1 : totalPage;
			
			selectPage=selectPage>totalPage? totalPage : selectPage;
			
			int firstIndex=total==0?0:rowsPerPage*(selectPage-1);
			info.setFirstIndex(firstIndex);
			suppliers=supplyDao.getSuppliers(info);
			
			
		}else{
			totalPage=1;
			selectPage=1;
		}

		
		info.setSelectPage(selectPage);
		info.setTotalCount(total);
		info.setTotalPage(totalPage);
		info.setSuppliers(suppliers);
		
		return info;
	}

	@Override
	public List<ImpSales> getImpSales(String comp_id) {		
		return sst.getMapper(SupplyManageDao.class).getImpSales(comp_id);
	}


	@Override
	public List<ComnCodUtilModel> getComnCod() {
		List<ComnCodUtilModel> list =sst.getMapper(SupplyManageDao.class).getComnCod();
		return list;
	}
	
	

}
