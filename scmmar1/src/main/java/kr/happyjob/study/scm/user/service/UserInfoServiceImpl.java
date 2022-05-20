package kr.happyjob.study.scm.user.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.login.model.UserInfo;
import kr.happyjob.study.scm.user.dao.UserInfoDao;
import kr.happyjob.study.scm.user.exception.UserExistException;
import kr.happyjob.study.scm.user.model.PageInfo;
import kr.happyjob.study.scm.user.model.User;
import kr.happyjob.study.scm.user.model.UserDetail;
import kr.happyjob.study.scm.user.model.UserRegData;
import kr.happyjob.study.system.model.ComnCodUtilModel;

@Service
public class UserInfoServiceImpl implements UserInfoService {
	
	private final Logger logger=LogManager.getLogger(this.getClass());
	
	private SqlSessionTemplate sst;
	private UserInfoDao uiDao;
	
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
		
		uiDao=sst.getMapper(UserInfoDao.class);
		
		int selectPage=param.getSelectPage();
		int rowsPerPage=param.getRowsPerPage();
		int totalPage=Integer.parseInt(param.getTotalPage());
		
		int totalCount= uiDao.getTotalCount(param);
		
		List<User> userList=null;
		
		if(totalCount>0){
			totalPage=totalCount/rowsPerPage;
			totalPage=totalCount%rowsPerPage==0?totalPage:totalPage+1;
			selectPage=selectPage>totalPage?totalPage:selectPage;
			param.setFirstIndex(rowsPerPage*(selectPage-1));
			userList=uiDao.getUserList(param);
			logger.info("+totalPage : "+totalPage);
		}else{
			totalPage=1;
		}
		
		param.setUserlist(userList);
		param.setSelectPage(selectPage);
		param.setTotalPage(String.valueOf(totalPage));
		param.setTotalCount(totalCount);
		param.setUserlist(userList);

		return param;
	}

	@Override
	public int insertUser(UserRegData data) throws UserExistException {
		int result=0;
		UserDetail detail=getUserInfo(data.getLoginID(), null);
		if(detail!=null){
			throw new UserExistException();
		}else{
			result=uiDao.insertUser(data);
		}
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
