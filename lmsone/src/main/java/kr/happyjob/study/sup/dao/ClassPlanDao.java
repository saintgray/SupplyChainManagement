package kr.happyjob.study.sup.dao;

import java.util.List;
import java.util.Map;

public interface ClassPlanDao {

	int countClassPlan(Map<String, Object> paramMap);

	List<Map<String, Object>> selectClassPlanList(Map<String, Object> paramMap);

	List<Map<String, Object>> selectListTeacher(Map<String, Object> paramMap);

	List<Map<String, Object>> selectListClassRoom(Map<String, Object> paramMap);

	void registerClassPlan(Map<String, Object> paramMap);

	void deleteClassPlan(List<String> paramList);

	void deleteCourseList(List<String> paramList);

	Map<String, Object> classPlanDtlInfo(Map<String, Object> paramMap);

	void updateClassPlan(Map<String, Object> paramMap);

}
