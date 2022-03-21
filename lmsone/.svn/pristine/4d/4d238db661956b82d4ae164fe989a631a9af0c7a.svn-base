package kr.happyjob.study.mng.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.mng.dao.ClassInfoDao;
import kr.happyjob.study.mng.model.ClassListUserInfoDto;
import kr.happyjob.study.mng.model.ClassTInfoDto;


@Service
public class ClassInfoServiceImpl implements ClassInfoService {
	
	@Autowired
	private ClassInfoDao classInfoDao;


	@Override
	public int selectClassListCnt(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return classInfoDao.selectClassListCnt(map);
	}

	@Override
	public List<ClassTInfoDto> selectClassList(Map<String, Object> map, RowBounds rb) throws Exception {
		// TODO Auto-generated method stub
		return classInfoDao.selectClassList(map, rb);
	}

	@Override
	public int selectUserListCnt(int class_No) throws Exception {
		// TODO Auto-generated method stub
		return classInfoDao.selectUserListCnt(class_No);
	}

	@Override
	public List<ClassListUserInfoDto> selectUserList(int class_No, RowBounds rb) throws Exception {
		// TODO Auto-generated method stub
		return classInfoDao.selectUserList(class_No, rb);
	}
}
