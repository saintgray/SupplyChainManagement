package kr.happyjob.study.tmg.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.tmg.dao.TeacherListDao;
@Service
public class TeacherListServiceImpl implements TeacherListService {
	@Autowired 
	TeacherListDao teacherListDao;
	
	@Override
	public List<Map<String, Object>> selectTeacherList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return teacherListDao.selectTeacherList(paramMap);
	}

	@Override
	public int countTeacher(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return teacherListDao.countTeacher(paramMap);
	}

	@Override
	public Map<String, Object> teacherDtlInfo(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return teacherListDao.teacherDtlInfo(paramMap);
	}
	
}
