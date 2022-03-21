package kr.happyjob.study.sup.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.sup.dao.ClassPlanDao;

@Service
public class ClassPlanServiceImpl implements ClassPlanService{
	@Autowired
	ClassPlanDao classPlanDao;
	
	@Override
	public List<Map<String, Object>> selectClassPlanList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return classPlanDao.selectClassPlanList(paramMap);
	}

	@Override
	public int countClassPlan(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return classPlanDao.countClassPlan(paramMap);
	}

	@Override
	public List<Map<String, Object>> selectListTeacher(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return classPlanDao.selectListTeacher(paramMap);
	}

	@Override
	public List<Map<String, Object>> selectListClassRoom(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return classPlanDao.selectListClassRoom(paramMap);
	}

	@Override
	public void registerClassPlan(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		classPlanDao.registerClassPlan(paramMap);
	}

	@Override
	public void deleteClassPlan(List<String> paramList) throws Exception {
		// TODO Auto-generated method stub
		classPlanDao.deleteClassPlan(paramList);
	}

	@Override
	public void deleteCourseList(List<String> paramList) throws Exception {
		// TODO Auto-generated method stub
		classPlanDao.deleteCourseList(paramList);
	}

	@Override
	public Map<String, Object> classPlanDtlInfo(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return classPlanDao.classPlanDtlInfo(paramMap);
	}

	@Override
	public void updateClassPlan(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		classPlanDao.updateClassPlan(paramMap);
	}

}
