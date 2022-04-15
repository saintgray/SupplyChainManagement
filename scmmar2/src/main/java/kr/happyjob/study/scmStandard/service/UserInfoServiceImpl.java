package kr.happyjob.study.scmStandard.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scmStandard.dao.UserInfoDao;
import kr.happyjob.study.scmStandard.model.UserInfoModel;
import kr.happyjob.study.system.model.ComnGrpCodModel;


@Service
public class UserInfoServiceImpl implements UserInfoService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	UserInfoDao userInfoDao;
	
	/** 고객정보 목록 조회 */
	public List<UserInfoModel> listUserInfo(Map<String, Object> paramMap) throws Exception {
		
		List<UserInfoModel> listUserInfo = userInfoDao.listUserInfo(paramMap);
		
		return listUserInfo;
	}
	
	/** 고객정보 목록 카운트 조회 */
	public int countListUserInfo(Map<String, Object> paramMap) throws Exception {
		
		int totalCount = userInfoDao.countListUserInfo(paramMap);
		
		return totalCount;
	}
	
	/** 고객정보 단건 조회 */
	public UserInfoModel selectUserInfo(Map<String, Object> paramMap) throws Exception {
		
		UserInfoModel userInfoModel = userInfoDao.selectUserInfo(paramMap);
		return userInfoModel;
	}
	
	/** 고객정보 저장 */
	public int insertUserInfo(Map<String, Object> paramMap) throws Exception {
		
		int ret = userInfoDao.insertUserInfo(paramMap);
		
		return ret;
	}
	
	/** 고객정보 수정 */
	public int updateUserInfo(Map<String, Object> paramMap) throws Exception {
		
		int ret = userInfoDao.updateUserInfo(paramMap);
		return ret;
	}
	
	/** 고객정보 삭제 */
	public int deleteUserInfo(Map<String, Object> paramMap) throws Exception {
		
		int ret = userInfoDao.deleteUserInfo(paramMap);
		
		return ret;
	}
	
	
}