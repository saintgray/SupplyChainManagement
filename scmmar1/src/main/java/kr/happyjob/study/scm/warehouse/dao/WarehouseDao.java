package kr.happyjob.study.scm.warehouse.dao;

import java.util.List;

import kr.happyjob.study.scm.warehouse.model.PageInfo;
import kr.happyjob.study.scm.warehouse.model.Warehouse;
import kr.happyjob.study.scm.warehouse.model.WarehouseDetail;
import kr.happyjob.study.system.model.ComnCodUtilModel;

public interface WarehouseDao {
	
	
	List<Warehouse> getWarehouseList(PageInfo info);
	int getTotalCount(PageInfo info);
	WarehouseDetail getWareHouseInfo(String idx);
	List<ComnCodUtilModel> getLocComnCod(String group_code);
	int insertWarehouse(WarehouseDetail data);
	int deleteWarehouse(String wh_id);
	int updateWarehouse(WarehouseDetail data);
	int getWareHouseStock(String wh_id);

}
