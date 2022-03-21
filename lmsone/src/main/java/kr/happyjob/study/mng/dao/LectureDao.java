package kr.happyjob.study.mng.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import kr.happyjob.study.mng.model.FileInfoDto;
import kr.happyjob.study.mng.model.LectureDto;

public interface LectureDao {

	int selectLectureListCnt(String loginID)  throws Exception;

	List<LectureDto> selectLectureList(String loginID, RowBounds rb)  throws Exception;

	LectureDto selectLecture(int class_No) throws Exception;

	FileInfoDto selectPlanFileInfo(int no)  throws Exception;

}
