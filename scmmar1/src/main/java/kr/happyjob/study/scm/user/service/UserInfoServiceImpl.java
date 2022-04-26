package kr.happyjob.study.scm.user.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.user.dao.UserInfoDao;
import kr.happyjob.study.scm.user.model.PageInfo;
import kr.happyjob.study.scm.user.model.User;
import kr.happyjob.study.scm.user.model.UserDetail;
import kr.happyjob.study.scm.user.model.UserRegData;
import kr.happyjob.study.system.model.ComnCodUtilModel;

@Service
public class UserInfoServiceImpl implements UserInfoService {
	
	private final Logger logger=LogManager.getLogger(this.getClass());
	
	private SqlSessionTemplate sst;
	
	public UserInfoServiceImpl() {
	
	}
	
	@Autowired
	public UserInfoServiceImpl(SqlSessionTemplate sst) {
	
		this.sst = sst;
	}
	
	@Override
	public UserDetail getUserInfo(String userID,String pur_idx){
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("userID", userID);
		map.put("pur_idx", pur_idx);
		return sst.getMapper(UserInfoDao.class).getUserInfo(map);
	}

	@Override
	public PageInfo getUserList(PageInfo param) {
		
		param.setFirstIndex(param.getRowsPerPage()*(param.getSelectPage()-1));
		
		List<User> userlist=sst.getMapper(UserInfoDao.class).getUserList(param);
		param.setUserlist(userlist);
		
		param.setTotalCount(sst.getMapper(UserInfoDao.class).getTotalCount(param));
		
		return param;
	}

	@Override
	public int insertUser(UserRegData data) {
		int result=0;
		logger.info("+user_Type......?"+data.getUser_Type());
		// result=sst.getMapper(UserInfoDao.class).insertUser(data);
		return result;
	}

	@Override
	public int updateUser(UserRegData data) {
		int result=0;

		result=sst.getMapper(UserInfoDao.class).updateUser(data);
		return result;
	}

	@Override
	public int deleteUser(String userID) {
		
		return sst.getMapper(UserInfoDao.class).deleteUser(userID);
	}
	
	@Override
	public int getTotalCount(PageInfo info){
		return sst.getMapper(UserInfoDao.class).getTotalCount(info);
	}

	@Override
	// 창고의 담당자는 배송관리자에 한한다.
	public List<ComnCodUtilModel> getAdvisorCod(String group_code) {
		
		return sst.getMapper(UserInfoDao.class).getComnCod(group_code);
	}

	
	
	
	
	

}
