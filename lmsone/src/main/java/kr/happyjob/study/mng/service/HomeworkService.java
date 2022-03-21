package kr.happyjob.study.mng.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.web.multipart.MultipartFile;

import kr.happyjob.study.mng.model.ClassInfoDto;
import kr.happyjob.study.mng.model.FileInfoDto;
import kr.happyjob.study.mng.model.HomeworkDto;
import kr.happyjob.study.mng.model.HwSubmitDto;
import kr.happyjob.study.mng.model.HwSubmitInfoDto;

public interface HomeworkService {

	int selectCIListCnt(String loginID) throws Exception;

	List<ClassInfoDto> selectClassList(String loginID, RowBounds rb) throws Exception;

	int selectHWListCnt(int class_No) throws Exception;

	List<HomeworkDto> selectHomeworkList(int class_No, RowBounds rb) throws Exception;

	HomeworkDto selectHomework(int hw_No) throws Exception;

	void insertHwsubmit(HwSubmitDto hwsubmit, FileInfoDto fileInfo, MultipartFile homeworkFile) throws Exception;

	HwSubmitDto selectCheckSubmit(HwSubmitDto temp) throws Exception;

	FileInfoDto selectFileInfo(int hw_No) throws Exception;

	void updateHwsubmit(HwSubmitDto hwsubmit, FileInfoDto fileInfo, MultipartFile homeworkFile, String fileCheck,
			String fileDelCheck) throws Exception;

	void deleteHwsubmit(int hw_Submit_No, String fileCheck, int no) throws Exception;

	int selectCITListCnt(String loginID) throws Exception;

	List<ClassInfoDto> selectClassTList(String loginID, RowBounds rb) throws Exception;

	int insertHomework(HomeworkDto homework, FileInfoDto fileInfo, MultipartFile homeworkFile)  throws Exception;

	void updateHomework(HomeworkDto homework, FileInfoDto fileInfo, MultipartFile homeworkFile, String fileCheck,
			String fileDelCheck) throws Exception;

	void deleteHomework(int hw_No, String fileCheck, int no)  throws Exception;

	int selectHWSubmitListCnt(int hw_No) throws Exception;

	List<HwSubmitInfoDto> selectHWSubmitList(int hw_No, RowBounds rb) throws Exception;

	HwSubmitDto selectTHwsubmit(int hw_Submit_No) throws Exception;

}
