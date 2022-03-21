package kr.happyjob.study.mng.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.mng.dao.LectureDao;
import kr.happyjob.study.mng.model.FileInfoDto;
import kr.happyjob.study.mng.model.LectureDto;

@Service
public class LectureServiceImpl implements LectureService {

	@Autowired
	private LectureDao lectureDao;

	@Override
	public int selectLectureListCnt(String loginID) throws Exception {
		// TODO Auto-generated method stub
		return lectureDao.selectLectureListCnt(loginID);
	}

	@Override
	public List<LectureDto> selectLectureList(String loginID, RowBounds rb) throws Exception {
		// TODO Auto-generated method stub
		return lectureDao.selectLectureList(loginID, rb);
	}

	@Override
	public LectureDto selectLecture(int class_No) throws Exception {
		// TODO Auto-generated method stub
		return lectureDao.selectLecture(class_No);
	}

	@Override
	public FileInfoDto selectPlanFileInfo(int no) throws Exception {
		// TODO Auto-generated method stub
		return lectureDao.selectPlanFileInfo(no);
	}
}
