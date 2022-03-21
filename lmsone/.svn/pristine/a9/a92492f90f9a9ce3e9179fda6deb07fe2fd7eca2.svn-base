package kr.happyjob.study.mng.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import kr.happyjob.study.mng.model.ClassInfoDto;
import kr.happyjob.study.mng.model.FileInfoDto;
import kr.happyjob.study.mng.model.HomeworkDto;
import kr.happyjob.study.mng.model.HwSubmitDto;
import kr.happyjob.study.mng.model.HwSubmitInfoDto;

public interface HomeworkDao {

	int selectCIListCnt(String loginID) throws Exception;	

	List<ClassInfoDto> selectClassList(String loginID, RowBounds rb) throws Exception;

	int selectHWListCnt(int class_No)  throws Exception;

	List<HomeworkDto> selectHomeworkList(int class_No, RowBounds rb)  throws Exception;

	HomeworkDto selectHomework(int hw_No) throws Exception;

	void insertFileInfo(FileInfoDto fileInfo) throws Exception;

	void insertHwsubmit(HwSubmitDto hwsubmit) throws Exception;

	HwSubmitDto selectCheckSubmit(HwSubmitDto temp) throws Exception;

	FileInfoDto selectFileInfo(int file_No) throws Exception;

	void updateFileInfo(FileInfoDto fileInfo) throws Exception;

	void updateHwsubmit(HwSubmitDto hwsubmit) throws Exception;

	void deleteFileInfo(FileInfoDto temp) throws Exception;

	void deleteHwsubmit(int hw_Submit_No) throws Exception;

	int selectCITListCnt(String loginID) throws Exception;

	List<ClassInfoDto> selectClassTList(String loginID, RowBounds rb) throws Exception;

	void insertHomework(HomeworkDto homework) throws Exception;

	void updateHomework(HomeworkDto homework) throws Exception;

	void deleteHomework(int hw_No) throws Exception;

	int selectHWSubmitListCnt(int hw_No) throws Exception;

	List<HwSubmitInfoDto> selectHWSubmitList(int hw_No, RowBounds rb) throws Exception;

	HwSubmitDto selectTHwsubmit(int hw_Submit_No) throws Exception;

}
