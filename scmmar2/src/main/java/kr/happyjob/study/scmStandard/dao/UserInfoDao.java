package kr.happyjob.study.scmStandard.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scmStandard.model.UserInfoModel;
import kr.happyjob.study.system.model.ComnGrpCodModel;

public interface UserInfoDao {
	
	/** 고객정보 목록 조회 */
	//listUserInfo 가 쿼리문 ID가 됌.
	public List<UserInfoModel> listUserInfo(Map<String, Object> paramMap);
	
	/** 고객정보 목록 카운트 조회 */
	public int countListUserInfo(Map<String, Object> paramMap);
	
	/** 고객정보 단건 조회 */
	public UserInfoModel selectUserInfo(Map<String, Object> paramMap);
	
	/** 고객정보 저장 */
	public int insertUserInfo(Map<String, Object> paramMap);
	
	/** 고객정보 수정 */
	public int updateUserInfo(Map<String, Object> paramMap);

	/** 고객정보 삭제 */
	public int deleteUserInfo(Map<String, Object> paramMap);

}
