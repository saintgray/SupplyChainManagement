package kr.happyjob.study.scm.orders.service;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.epc.dao.ShoppingCartDao;
import kr.happyjob.study.scm.orders.dao.DailyOrderHistoryDao;
import kr.happyjob.study.scm.orders.dao.DirDao;
import kr.happyjob.study.scm.orders.model.DirModel;
import kr.happyjob.study.scm.refund.exception.NotConfirmedException;
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
	public int insertShippingDir(List<String> idxList, List<String> exportTarget,String pur_id, String action) {
		
		logger.info("+into insertShipping Dir...");
		logger.info("+ idxList... " + idxList);
		int result=0;
		
		List<DirModel> regData= new LinkedList<DirModel>();
		
		
		
		Map<String, Object> params=new HashMap<String, Object>();
		params.put("pur_id", pur_id);
		
		
		salesDao=sst.getMapper(SalesManageDao.class);
		// [158,1   ,   159,1] 문자열 리스트 반환
		List<String> salesIdList=salesDao.selectAllSalesByPurchaseIdx(idxList);
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
		
		dirDao=sst.getMapper(DirDao.class);
		logger.info("+dirDao Empty??? " + String.valueOf(dirDao==null));
		result=dirDao.insertShippingDir(regData);
				
			
		return result;
	}

	@Override
	public int insertOrderDir(List<String> targetCompSales, HttpSession session) throws Exception {
		int result=0;
		
		// 1. 주문/발주 테이블에 insert
		// 2. 의 PK 를 가지고 targetWh(창고번호, 상품번호 쌍) 에 있는 정보로 발주상세 테이블에 insert
		// 3. 의 PK 를 가지고 발주 지시서 insert
		
		Map<String, Object> paramMap=new HashMap<>();
		paramMap.put("pur_id", "");
		paramMap.put("userType", session.getAttribute("userType").toString());
		paramMap.put("loginID", session.getAttribute("loginId").toString());
		
		result=sst.getMapper(ShoppingCartDao.class).orderProductPurchase(paramMap);
		
		
		Map<String, Object> orderInfParamMap=new HashMap<>();
		orderInfParamMap.put("fk","");
		orderInfParamMap.put("loginID", paramMap.get("loginID"));
		orderInfParamMap.put("pur_id", paramMap.get("pur_id"));
		
		for(String arg : targetCompSales){
			orderInfParamMap.put("sales_id", arg.split(",")[0]);
			orderInfParamMap.put("com_code", arg.split(",")[1]);
			orderInfParamMap.put("com_cnt", arg.split(",")[2]);
			
			result=sst.getMapper(DailyOrderHistoryDao.class).insertcom2(orderInfParamMap);
			
				Map<String, Object> orderDirMap=new HashMap<>();
				orderDirMap.put("fk", orderInfParamMap.get("fk"));
				result=sst.getMapper(DailyOrderHistoryDao.class).insertcom1(orderDirMap);
		}
		
		
		
		return result;
	}

	/**
	 * @param idx : 반품 정보 고유번호
	 */
	@Override
	public int insertReturnDir(String idx) {
		
		dirDao=sst.getMapper(DirDao.class);
		
		
		
		int result=0;
		result=dirDao.insertReturnDir(idx);
		return result;
	}
	
	/**
	 * @param idx : 반품지시서 고유번호
	 */
	@Override
	public int insertDelivDir(String idx) throws Exception {
		
		dirDao=sst.getMapper(DirDao.class);
		String confirmed=dirDao.getConfirmed(idx);
		logger.info("+ is confirmed?? " + confirmed);
		
		
		int result=0;
		if(confirmed!=null && confirmed.equals("Y")){
			result=dirDao.insertDelivDir(idx);
		}else{
			throw new NotConfirmedException();
		}
		
		return result;
	}

	
}
