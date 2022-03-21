package kr.happyjob.study.mng.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.happyjob.study.mng.dao.HomeworkDao;
import kr.happyjob.study.mng.model.ClassInfoDto;
import kr.happyjob.study.mng.model.FileInfoDto;
import kr.happyjob.study.mng.model.HomeworkDto;
import kr.happyjob.study.mng.model.HwSubmitDto;
import kr.happyjob.study.mng.model.HwSubmitInfoDto;

@Service
public class HomeworkServiceImpl implements HomeworkService {
	
	@Autowired
	private HomeworkDao homeworkDao;

	@Override
	public int selectCIListCnt(String loginID) throws Exception {
		// TODO Auto-generated method stub
		return homeworkDao.selectCIListCnt(loginID);
	}

	@Override
	public List<ClassInfoDto> selectClassList(String loginID, RowBounds rb) throws Exception {
		// TODO Auto-generated method stub
		return homeworkDao.selectClassList(loginID,rb);
	}

	@Override
	public int selectHWListCnt(int class_No) throws Exception {
		// TODO Auto-generated method stub
		return homeworkDao.selectHWListCnt(class_No);
	}

	@Override
	public List<HomeworkDto> selectHomeworkList(int class_No, RowBounds rb) throws Exception {
		// TODO Auto-generated method stub
		return homeworkDao.selectHomeworkList(class_No, rb);
	}

	@Override
	public HomeworkDto selectHomework(int hw_No) throws Exception {
		// TODO Auto-generated method stub
		return homeworkDao.selectHomework(hw_No);
	}

	
	@Override
	public void insertHwsubmit(HwSubmitDto hwsubmit, FileInfoDto fileInfo, MultipartFile homeworkFile)
			throws Exception {
		String path = null;
		String fileName = null;
		String middleName = null;
		
		if(!homeworkFile.isEmpty()){
			path = fileInfo.getFile_Root();
			fileName = fileInfo.getFile_Name();
			middleName = fileInfo.getFile_Title();
			
			new File(path).mkdirs();
			homeworkDao.insertFileInfo(fileInfo);
			hwsubmit.setNo(fileInfo.getFile_No());
		}
		
		
		
		
		homeworkDao.insertHwsubmit(hwsubmit);
		
		if(!homeworkFile.isEmpty()){
			try {
				homeworkFile.transferTo(new File(path +middleName+ fileName));
			} catch (IllegalStateException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				throw new RuntimeException("파일 업로드 에러");
			}
			
		}
			
		
	}

	@Override
	public HwSubmitDto selectCheckSubmit(HwSubmitDto temp) throws Exception {
		// TODO Auto-generated method stub
		return homeworkDao.selectCheckSubmit(temp);
	}

	@Override
	public FileInfoDto selectFileInfo(int file_No) throws Exception {
		// TODO Auto-generated method stub
		return homeworkDao.selectFileInfo(file_No);
	}

	@Override
	public void updateHwsubmit(HwSubmitDto hwsubmit, FileInfoDto fileInfo, MultipartFile homeworkFile, String fileCheck,
			String fileDelCheck) throws Exception {
		
		String path = null;
		String fileName = null;
		String middleName = null;
		String fileUpdateCheck = "N";
		FileInfoDto temp = null;
		if(fileCheck.equals("Y")){
			temp = homeworkDao.selectFileInfo(hwsubmit.getNo());
		}
		if(!homeworkFile.isEmpty()){
			path = fileInfo.getFile_Root();
			fileName = fileInfo.getFile_Name();
			middleName = fileInfo.getFile_Title();
			
			new File(path).mkdirs();
			if(fileCheck.equals("Y")){
				fileUpdateCheck = "Y";
				fileInfo.setFile_No(hwsubmit.getNo());
				homeworkDao.updateFileInfo(fileInfo);
			}else{
				homeworkDao.insertFileInfo(fileInfo);
			}			
			hwsubmit.setNo(fileInfo.getFile_No());
		}
		
		if(fileDelCheck.equals("Y")){
			homeworkDao.deleteFileInfo(temp);
			hwsubmit.setNo(0);
		}
		
		
		homeworkDao.updateHwsubmit(hwsubmit);
		
		if(!homeworkFile.isEmpty()){
			try {
				homeworkFile.transferTo(new File(path +middleName+ fileName));
			} catch (IllegalStateException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				throw new RuntimeException("파일 업로드 에러");
			}
			
		}
		
		if(fileUpdateCheck.equals("Y")||fileDelCheck.equals("Y")){
			new File(temp.getFile_Root()+temp.getFile_Title()+temp.getFile_Name()).delete();
		}
		
	}

	@Override
	public void deleteHwsubmit(int hw_Submit_No, String fileCheck, int no) throws Exception {

		FileInfoDto temp = null;
		if(fileCheck.equals("Y")){
			temp = homeworkDao.selectFileInfo(no);
			homeworkDao.deleteFileInfo(temp);
		}
		
		homeworkDao.deleteHwsubmit(hw_Submit_No);
		
		if(fileCheck.equals("Y")){
			new File(temp.getFile_Root()+temp.getFile_Title()+temp.getFile_Name()).delete();
		}
		
		
	}

	@Override
	public int selectCITListCnt(String loginID) throws Exception {
		// TODO Auto-generated method stub
		return homeworkDao.selectCITListCnt(loginID);
	}

	@Override
	public List<ClassInfoDto> selectClassTList(String loginID, RowBounds rb) throws Exception {
		// TODO Auto-generated method stub
		return homeworkDao.selectClassTList(loginID,rb);
	}

	@Override
	public int insertHomework(HomeworkDto homework, FileInfoDto fileInfo, MultipartFile homeworkFile)
			throws Exception {
		String path = null;
		String fileName = null;
		String middleName = null;
		
		if(!homeworkFile.isEmpty()){
			path = fileInfo.getFile_Root();
			fileName = fileInfo.getFile_Name();
			middleName = fileInfo.getFile_Title();
			
			new File(path).mkdirs();
			homeworkDao.insertFileInfo(fileInfo);
			homework.setNo(fileInfo.getFile_No());
		}
		
		
		
		
		homeworkDao.insertHomework(homework);
		
		if(!homeworkFile.isEmpty()){
			try {
				homeworkFile.transferTo(new File(path +middleName+ fileName));
			} catch (IllegalStateException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				throw new RuntimeException("파일 업로드 에러");
			}
			
		}
		return homework.getHw_No();
		
	}

	@Override
	public void updateHomework(HomeworkDto homework, FileInfoDto fileInfo, MultipartFile homeworkFile, String fileCheck,
			String fileDelCheck) throws Exception {
		
		String path = null;
		String fileName = null;
		String middleName = null;
		String fileUpdateCheck = "N";
		FileInfoDto temp = null;
		if(fileCheck.equals("Y")){
			temp = homeworkDao.selectFileInfo(homework.getNo());
		}
		if(!homeworkFile.isEmpty()){
			path = fileInfo.getFile_Root();
			fileName = fileInfo.getFile_Name();
			middleName = fileInfo.getFile_Title();
			
			new File(path).mkdirs();
			if(fileCheck.equals("Y")){
				fileUpdateCheck = "Y";
				fileInfo.setFile_No(homework.getNo());
				homeworkDao.updateFileInfo(fileInfo);
			}else{
				homeworkDao.insertFileInfo(fileInfo);
			}			
			homework.setNo(fileInfo.getFile_No());
		}
		
		if(fileDelCheck.equals("Y")){
			homeworkDao.deleteFileInfo(temp);
			homework.setNo(0);
		}
		
		
		homeworkDao.updateHomework(homework);
		
		if(!homeworkFile.isEmpty()){
			try {
				homeworkFile.transferTo(new File(path +middleName+ fileName));
			} catch (IllegalStateException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				throw new RuntimeException("파일 업로드 에러");
			}
			
		}
		
		if(fileUpdateCheck.equals("Y")||fileDelCheck.equals("Y")){
			new File(temp.getFile_Root()+temp.getFile_Title()+temp.getFile_Name()).delete();
		}
		
	}

	@Override
	public void deleteHomework(int hw_No, String fileCheck, int no) throws Exception {
		FileInfoDto temp = null;
		if(fileCheck.equals("Y")){
			temp = homeworkDao.selectFileInfo(no);
			homeworkDao.deleteFileInfo(temp);
		}
		
		homeworkDao.deleteHomework(hw_No);
		
		if(fileCheck.equals("Y")){
			new File(temp.getFile_Root()+temp.getFile_Title()+temp.getFile_Name()).delete();
		}
		
	}

	@Override
	public int selectHWSubmitListCnt(int hw_No) throws Exception {
		// TODO Auto-generated method stub
		return homeworkDao.selectHWSubmitListCnt(hw_No);
	}

	@Override
	public List<HwSubmitInfoDto> selectHWSubmitList(int hw_No, RowBounds rb) throws Exception {
		// TODO Auto-generated method stub
		return homeworkDao.selectHWSubmitList(hw_No,rb);
	}

	@Override
	public HwSubmitDto selectTHwsubmit(int hw_Submit_No) throws Exception {
		// TODO Auto-generated method stub
		return homeworkDao.selectTHwsubmit(hw_Submit_No);
	}

	
}

