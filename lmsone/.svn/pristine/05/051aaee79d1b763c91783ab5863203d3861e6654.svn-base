package kr.happyjob.study.mng.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import kr.happyjob.study.mng.model.ClassListUserInfoDto;
import kr.happyjob.study.mng.model.ClassTInfoDto;

public interface ClassInfoDao {

	//강의목록 총갯수(검색 적용)
	int selectClassListCnt(Map<String, Object> map)  throws Exception;

	//강의목록 리스트(검색 적용)
	List<ClassTInfoDto> selectClassList(Map<String, Object> map, RowBounds rb)  throws Exception;

	//선택강의 관련 수강인원 총갯수
	int selectUserListCnt(int class_No) throws Exception;
	
	//선택강의 관련 수강인원 리스트
	List<ClassListUserInfoDto> selectUserList(int class_No, RowBounds rb) throws Exception;

	

}
