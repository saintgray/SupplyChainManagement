package kr.happyjob.study.tmg.service;

import java.util.List;
import java.util.Map;

public interface TeacherListService {

	List<Map<String, Object>> selectTeacherList(Map<String, Object> paramMap) throws Exception;

	int countTeacher(Map<String, Object> paramMap) throws Exception;

	Map<String, Object> teacherDtlInfo(Map<String, Object> paramMap) throws Exception;


}
