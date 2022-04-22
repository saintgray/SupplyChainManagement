package kr.happyjob.study.scm.orders.dao;

import java.util.List;

import kr.happyjob.study.scm.orders.model.DirModel;

public interface DirDao {

	int getPurchaseType(String pur_id);
	int countRefundInfoByByPurId(String pur_id);
	int insertShippingDir(List<DirModel> regData);
	int countRefundDirByPurInfIdx(String purchaseType, List<String> idxList, String checkConfirm);
}
