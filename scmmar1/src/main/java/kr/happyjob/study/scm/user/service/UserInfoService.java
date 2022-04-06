package kr.happyjob.study.scm.user.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.user.model.PageInfo;
import kr.happyjob.study.scm.user.model.User;
import kr.happyjob.study.scm.user.model.UserDetail;
import kr.happyjob.study.scm.user.model.UserRegData;
import kr.happyjob.study.system.model.ComnCodUtilModel;



@Service
public interface UserInfoService {
	
	UserDetail getUserInfo(String userID);
	PageInfo getUserList(PageInfo param);
	int insertUser(UserRegData data);
	int updateUser(UserRegData data);
	int deleteUser(String userID);
	int getTotalCount(PageInfo info);
	List<ComnCodUtilModel> getAdvisorCod(String group_code);
	

}
