package kr.happyjob.study.mng.dao;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

public interface TakeExamDao {
	
	/** 시험 목록 조회 */
	public List<Map<String, Object>> listTexam(Map<String, Object> paramMap);
	
	/** 조회된 총 시험 수 조회 */
	public int countListTexam(Map<String, Object> paramMap);
	
	/** 문항 작성 수 확인 */
	public int takeExamChk(Map<String, Object> paramMap);
	
	/** 시험 정보 가져오기 */
	public Map<String, String> takeExamGetInfo(Map<String, Object> paramMap);
	
	/** 시험 문항 조회 */
	public List<Map<String, Object>> callQuestionList(Map<String, Object> paramMap);
	
	/** 시험 문항 수 조회 */
	public int callQuestionListCnt(Map<String, Object> paramMap);
	
	/** 답안 제출 */
	public int submitExam(Map<String, Object> paramMap);
	
	/** DB에서 정답 가져오기 */
	public String solGroup(Map<String, Object> paramMap);
	
	/** qNo를 순서대로 출력(시험 중도 종료 시) */
	public String selectQno(Map<String, Object> paramMap);
	
	/** DB에 학생 점수 UPDATE */
	public int updateScore(Map<String, Object> paramMap);
}
