package kr.happyjob.study.mng.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import kr.happyjob.study.mng.model.ClassListUserInfoDto;
import kr.happyjob.study.mng.model.ClassTInfoDto;

public interface ClassInfoService {


	int selectClassListCnt(Map<String, Object> map)throws Exception;

	List<ClassTInfoDto> selectClassList(Map<String, Object> map, RowBounds rb) throws Exception;

	int selectUserListCnt(int class_No) throws Exception;

	List<ClassListUserInfoDto> selectUserList(int class_No, RowBounds rb) throws Exception;

}
