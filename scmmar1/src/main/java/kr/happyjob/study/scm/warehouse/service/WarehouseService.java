package kr.happyjob.study.scm.warehouse.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.warehouse.model.PageInfo;
import kr.happyjob.study.scm.warehouse.model.Warehouse;
import kr.happyjob.study.scm.warehouse.model.WarehouseDetail;
import kr.happyjob.study.system.model.ComnCodUtilModel;

@Service
public interface WarehouseService {
	
	PageInfo getWareHouseList(PageInfo param);
	WarehouseDetail getWareHouseInfo(String idx);
	List<ComnCodUtilModel> getLocCod(String group_code);

}
