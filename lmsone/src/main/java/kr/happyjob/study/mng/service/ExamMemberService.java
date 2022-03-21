package kr.happyjob.study.mng.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface ExamMemberService {

	/** 시험 목록 조회 */
	public List<Map<String, Object>> listExam2(Map<String, Object> paramMap) throws Exception;
	
	/** 조회된 총 시험 수 조회 */
	public int countListExam2(Map<String, Object> paramMap) throws Exception;
	
	/** 미출제 시험 유형 확인 */
	public Map<String, String> typeNullChk(Map<String, Object> paramMap) throws Exception;
	
	/** 선택한 시험의 응시자 목록 조회 */
	public List<Map<String, Object>> listExamMember(Map<String, Object> paramMap) throws Exception;
	
	/** 선택한 시험의 응시자 수 조회 */
	public int countListExamMember(Map<String, Object> paramMap) throws Exception;
}
