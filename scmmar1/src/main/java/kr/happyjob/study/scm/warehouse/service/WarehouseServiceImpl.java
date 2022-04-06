package kr.happyjob.study.scm.warehouse.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.warehouse.dao.WarehouseDao;
import kr.happyjob.study.scm.warehouse.model.PageInfo;
import kr.happyjob.study.scm.warehouse.model.Warehouse;
import kr.happyjob.study.scm.warehouse.model.WarehouseDetail;
import kr.happyjob.study.system.model.ComnCodUtilModel;

@Service
public class WarehouseServiceImpl implements WarehouseService{
	
	private SqlSessionTemplate sst;
	private WarehouseDao whDao;
	
	public WarehouseServiceImpl() {

	}

	@Autowired
	public WarehouseServiceImpl(SqlSessionTemplate sst) {
		
		this.sst = sst;
	}






	@Override
	public PageInfo getWareHouseList(PageInfo param) {
		
		
		whDao=sst.getMapper(WarehouseDao.class);
		
		
		
		param.setTotalCount(whDao.getTotalCount(param));

		int selectPage=param.getSelectPage();
		int rowsPerPage=param.getRowsPerPage();
		int total=param.getTotalCount();
		
		int totalPage=total/rowsPerPage;
		totalPage=total%rowsPerPage>0? totalPage+1 : totalPage;
		
		selectPage=selectPage>totalPage? totalPage : selectPage;
		
		param.setSelectPage(selectPage);
		
		
		
		param.setFirstIndex(param.getRowsPerPage()*(param.getSelectPage()-1));
		param.setWhList(whDao.getWarehouseList(param));
		
		
		
		return param;
	}

	@Override
	public WarehouseDetail getWareHouseInfo(String idx) {
	
		return sst.getMapper(WarehouseDao.class).getWareHouseInfo(idx);
	}

	@Override
	public List<ComnCodUtilModel> getLocCod(String group_code) {
		
		return sst.getMapper(WarehouseDao.class).getLocComnCod(group_code);
	}
	
	
	

}
