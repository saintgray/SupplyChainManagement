package kr.happyjob.study.scm.orders.service;

import java.util.LinkedList;
import java.util.List;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.orders.dao.DirDao;
import kr.happyjob.study.scm.orders.model.DirModel;
import kr.happyjob.study.scm.sales.dao.SalesManageDao;

@Service
public class DirServiceImpl implements DirService{

	
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	private SqlSessionTemplate sst;
	private DirDao dirDao;
	private SalesManageDao salesDao;
	
	public DirServiceImpl() {
		
	}

	@Autowired
	public DirServiceImpl(SqlSessionTemplate sst) {
		
		this.sst = sst;
	}




	@Override
	public int insertShippingDir(List<String> purinfIdxList, List<String> exportTarget,String userType, String action) {
		int result=0;
		
		List<DirModel> regData= new LinkedList<DirModel>();
		
		
		
		salesDao=sst.getMapper(SalesManageDao.class);
		List<String> salesIdList=salesDao.selectAllSalesByPurchaseIdx(purinfIdxList);
		for(String combo : exportTarget){
			String[] arr=combo.split(",");
			for(String purinfCombo: salesIdList){
				if(arr[1].equals(purinfCombo.split(",")[1])){
					regData.add(DirModel.standard()
								.withPurInf_id(purinfCombo.split(",")[0])
								.withDeliv_wh_id(arr[0]).build()
								);
				}
			}
		}
		
		
		for(DirModel item : regData){
			logger.info("+ purinfidx..." + item.getPurinf_id());
			logger.info("+ whIdx..." + item.getDeliv_wh_id());
		}
		//result=dirDao.insertShippingDir(regData);
		
		return result;
	}

	
}
