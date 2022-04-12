package kr.happyjob.study.scm.warehouse.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.happyjob.study.scm.warehouse.exception.StockRemainsException;
import kr.happyjob.study.scm.warehouse.model.PageInfo;
import kr.happyjob.study.scm.warehouse.model.Warehouse;
import kr.happyjob.study.scm.warehouse.model.WarehouseDetail;
import kr.happyjob.study.system.model.ComnCodUtilModel;

@Service
public interface WarehouseService {
	
	PageInfo getWareHouseList(PageInfo param);
	WarehouseDetail getWareHouseInfo(String idx,HttpSession session);
	List<ComnCodUtilModel> getLocCod(String group_code);
	int insertWarehouse(WarehouseDetail data);
	int deleteWarehouse(String wh_id) throws StockRemainsException;
	int updateWarehouse(WarehouseDetail data);
	

}
