package kr.happyjob.study.sup.service;

import java.util.List;
import java.util.Map;

public interface ClassPlanService {

	List<Map<String, Object>> selectClassPlanList(Map<String, Object> paramMap) throws Exception;

	int countClassPlan(Map<String, Object> paramMap) throws Exception;

	List<Map<String, Object>> selectListTeacher(Map<String, Object> paramMap) throws Exception;

	List<Map<String, Object>> selectListClassRoom(Map<String, Object> paramMap) throws Exception;

	void registerClassPlan(Map<String, Object> paramMap) throws Exception;

	void deleteClassPlan(List<String> paramList) throws Exception;

	void deleteCourseList(List<String> paramList) throws Exception;

	Map<String, Object> classPlanDtlInfo(Map<String, Object> paramMap) throws Exception;

	void updateClassPlan(Map<String, Object> paramMap) throws Exception;
	

}
