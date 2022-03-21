package kr.happyjob.study.mng.dao;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

import kr.happyjob.study.mng.model.ExamMgtModel;

public interface ExamDao {

	/** 기업 목록 조회 */
	public List<ExamMgtModel> listClass(Map<String, Object> paramMap);
	
	/** 조회된 총 기업 수 조회 */
	public int countListClass(Map<String, Object> paramMap);
	
	/** 선택한 강의에 등록된 시험 조회 */
	public List<ExamMgtModel> listExam(Map<String, Object> paramMap);
	
	/** 선택한 강의에 등록된 시험 총 개수 및 가장 높은 문항 번호 조회 */
	public Map<String, Object> countMapExam(Map<String, Object> paramMap);
	
	/** 문항 상세 조회 */
	public Map<String, Object> selectQuestion(Map<String, Object> paramMap);
	
	/** 응시자 수 조회 */
	public Map<String, Object> chkMemberCnt(Map<String, Object> paramMap);
	
	/** 문항 저장 INSERT */
	public int insertQuestion(Map<String, Object> paramMap);
	
	/** 문항 저장 UPDATE */
	public int updateQuestion(Map<String, Object> paramMap);
	
	/** 문항 관리 폼 문제 번호 중복 검사 */
	public int qNoCheck(Map<String, Object> paramMap);
	
	/** 문항 삭제 DELETE */
	public int deleteQuestion(Map<String, Object> paramMap);
}
