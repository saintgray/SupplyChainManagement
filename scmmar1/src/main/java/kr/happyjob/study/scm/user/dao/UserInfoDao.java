package kr.happyjob.study.scm.user.dao;

import java.util.List;

import kr.happyjob.study.scm.user.model.PageInfo;
import kr.happyjob.study.scm.user.model.User;
import kr.happyjob.study.scm.user.model.UserDetail;
import kr.happyjob.study.scm.user.model.UserRegData;
import kr.happyjob.study.system.model.ComnCodUtilModel;

public interface UserInfoDao {

	UserDetail getUserInfo(String userID);

	List<User> getUserList(PageInfo param);

	int getTotalCount(PageInfo param);

	int insertUser(UserRegData data);

	int updateUser(UserRegData data);

	int deleteUser(String userID);

	List<ComnCodUtilModel> getComnCod(String group_code);

}
