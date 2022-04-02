package kr.happyjob.study.scm.user.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;import kr.happyjob.study.login.model.UserInfo;
import kr.happyjob.study.scm.user.dao.UserInfoDao;
import kr.happyjob.study.scm.user.model.PageInfo;
import kr.happyjob.study.scm.user.model.User;
import kr.happyjob.study.scm.user.model.UserDetail;
import kr.happyjob.study.scm.user.model.UserRegData;

@Service
public class UserInfoServiceImpl implements UserInfoService {
	
	
	private SqlSessionTemplate sst;
	
	public UserInfoServiceImpl() {
	
	}
	
	@Autowired
	public UserInfoServiceImpl(SqlSessionTemplate sst) {
	
		this.sst = sst;
	}
	
	@Override
	public UserDetail getUserInfo(String userID){
		return sst.getMapper(UserInfoDao.class).getUserInfo(userID);
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
		
		return sst.getMapper(UserInfoDao.class).insertUser(data);
	}

	@Override
	public int updateUser(UserRegData data) {
		
		return sst.getMapper(UserInfoDao.class).updateUser(data);
	}

	@Override
	public int deleteUser(String userID) {
		
		return sst.getMapper(UserInfoDao.class).deleteUser(userID);
	}
	
	@Override
	public int getTotalCount(PageInfo info){
		return sst.getMapper(UserInfoDao.class).getTotalCount(info);
	}
	
	
	
	

}
