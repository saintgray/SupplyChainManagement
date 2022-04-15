package kr.happyjob.study.scmStandard.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scmStandard.model.UserInfoModel;
import kr.happyjob.study.system.model.ComnGrpCodModel;


public interface UserInfoService {

	/** 고객정보 목록 조회 */
	public List<UserInfoModel> listUserInfo(Map<String, Object> paramMap) throws Exception;
	
	/** 고객정보 목록 카운트 조회 */
	public int countListUserInfo(Map<String, Object> paramMap) throws Exception;
	
	/** 고객정보 단건 조회 */
	public UserInfoModel selectUserInfo(Map<String, Object> paramMap) throws Exception;
	
	/** 고객정보 수정 */
	public int updateUserInfo(Map<String, Object> paramMap) throws Exception;
	
	/** 고객정보 저장 */
	public int insertUserInfo(Map<String, Object> paramMap) throws Exception;
	
	/** 고객정보 삭제 */
	public int deleteUserInfo(Map<String, Object> paramMap) throws Exception;
	
}
