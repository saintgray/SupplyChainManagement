package kr.happyjob.study.scm.refund.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.Results;

import kr.happyjob.study.entity.PurchaseInfo;
import kr.happyjob.study.entity.RefundInfo;
import kr.happyjob.study.scm.refund.model.RefundInfoModel;

public interface RefundInfoDao {


	
	
	

//	@ResultMap(value="refundAlias")
//	@Results(value={
//			@Result(column="rfinfo_id",property="refundInfoId"),
//			@Result(column="account_number",property="accountNumber"),
//			@Result(column="account_holder",property="accountHolder"),
//			@Result(column="bank_name",property="bankName"),
//			@Result(column="return_cnt",property="returnCnt"),
//			@Result(column="regdate",property="regDate")
//	})
    public List<PurchaseInfo> refundInfoList(Map<String, Object> paramMap) throws Exception;
	// 총 값
	public int total(Map<String, Object> paramMap) throws Exception;
	// 단건 조회
	public RefundInfoModel onereinfo(Map<String, Object> paramMap) throws Exception;
	// 승인요청
	public int refupdate(Map<String,Object> paramMap) throws Exception;	
}