package kr.happyjob.study.scm.user.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Many;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.Results;

import kr.happyjob.study.entity.Member;
import kr.happyjob.study.entity.Purchase;
import kr.happyjob.study.scm.user.model.PageInfo;
import kr.happyjob.study.scm.user.model.User;
import kr.happyjob.study.scm.user.model.UserDetail;
import kr.happyjob.study.scm.user.model.UserRegData;
import kr.happyjob.study.system.model.ComnCodUtilModel;
import lombok.val;

public interface UserInfoDao {

	UserDetail getUserInfo(Map<String, Object> params);

	List<User> getUserList(PageInfo param);

	int getTotalCount(PageInfo param);

	int insertUser(UserRegData data);

	int updateUser(UserRegData data);

	int deleteUser(String userID);

	List<ComnCodUtilModel> getComnCod(String group_code);
	
	
//	@Results(value={
//			@Result(column="loginID", property="loginID"),
//			@Result(column="password",property="password"),
//			@Result(column="email",property="email"),
//			@Result(property="purchases", column="loginID", many=@Many(select="kr.happyjob.study.scm.user.dao.UserInfoDao.getPurchases"))
//	})
	List<Member> testGetUsers();
	
//	@Results(value={
//			@Result(column="pur_id", property="purId"),
//			@Result(column="purdate", property="purDate"),
//			@Result(column="depositYN", property="depositYN"),
//			@Result(column="type", property="type")
//	})
	List<Purchase> getPurchases();

}
