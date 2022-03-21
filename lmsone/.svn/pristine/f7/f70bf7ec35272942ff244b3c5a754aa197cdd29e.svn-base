package kr.happyjob.study.jmg.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import kr.happyjob.study.jmg.model.ResumeAwardInfoDto;
import kr.happyjob.study.jmg.model.ResumeCareerInfoDto;
import kr.happyjob.study.jmg.model.ResumeClassInfoDto;
import kr.happyjob.study.jmg.model.ResumeUserInfoDto;

public interface ResumeService {

	int selectAllClassListCnt(String keyword) throws Exception;

	List<ResumeClassInfoDto> selectAllClassList(String keyword, RowBounds rb) throws Exception;

	int selectResumeUserListCnt(int class_No) throws Exception;

	List<ResumeUserInfoDto> selectResumeUserList(int class_No, RowBounds rb) throws Exception;

	int selectUserClassListCnt(String loginID) throws Exception;

	List<ResumeClassInfoDto> selectUserClassList(String loginID, RowBounds rb) throws Exception;

	int selectUserAwardListCnt(String loginID) throws Exception;

	List<ResumeAwardInfoDto> selectUserAwardList(String loginID, RowBounds rb) throws Exception;

	ResumeUserInfoDto selectUser(String loginID) throws Exception;

	int selectUserCareerListCnt(String loginID) throws Exception;

	List<ResumeCareerInfoDto> selectUserCareerList(String loginID, RowBounds rb) throws Exception;

}
