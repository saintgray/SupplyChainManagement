package kr.happyjob.study.scm.warehouse.dao;

import java.util.List;

import kr.happyjob.study.scm.warehouse.model.PageInfo;
import kr.happyjob.study.scm.warehouse.model.Warehouse;
import kr.happyjob.study.scm.warehouse.model.WarehouseDetail;

public interface WarehouseDao {
	
	
	List<Warehouse> getWarehouseList(PageInfo info);
	int getTotalCount(PageInfo info);
	WarehouseDetail getWareHouseInfo(String idx);

}
