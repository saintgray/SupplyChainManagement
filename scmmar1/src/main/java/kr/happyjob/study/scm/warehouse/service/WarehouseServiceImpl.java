package kr.happyjob.study.scm.warehouse.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.happyjob.study.scm.warehouse.dao.WarehouseDao;
import kr.happyjob.study.scm.warehouse.exception.StockRemainsException;
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
	public WarehouseDetail getWareHouseInfo(String idx, HttpSession session) {
		WarehouseDetail detail=sst.getMapper(WarehouseDao.class).getWareHouseInfo(idx);
		// 수정 등록 삭제시에는 권한을 체크하는 NoticeManageAuthInterceptor 에서 SCM 담당자가 아닌 사람의 요청에 대해서는 튕겨내므로
		// 모든 사용자에 대해서 선택한 창고의 PK 값을 세션에 저장할 필요가 없다 (서버의 부하 증가 고려)
		if(session.getAttribute("userType").equals("A")){
			session.setAttribute("whID", detail.getWh_id());
		}
		return detail;
	}

	@Override
	public List<ComnCodUtilModel> getLocCod(String group_code) {
		
		return sst.getMapper(WarehouseDao.class).getLocComnCod(group_code);
	}

	@Override
	public int insertWarehouse(WarehouseDetail data) {
		
		return sst.getMapper(WarehouseDao.class).insertWarehouse(data);
	}

	@Override
	public int deleteWarehouse(String wh_id) throws StockRemainsException {
		
		int deleteResult=0;
		int stockCount= sst.getMapper(WarehouseDao.class).getWareHouseStock(wh_id);
		if(stockCount>0){
			throw new StockRemainsException();
		}else{
			deleteResult=sst.getMapper(WarehouseDao.class).deleteWarehouse(wh_id);
		}
		
		return deleteResult;
		
	}

	@Override
	public int updateWarehouse(WarehouseDetail data) {
		
		return sst.getMapper(WarehouseDao.class).updateWarehouse(data);
	}
	
	
	

}
