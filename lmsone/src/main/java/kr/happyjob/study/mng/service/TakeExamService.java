package kr.happyjob.study.mng.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface TakeExamService {

	/** 시험 목록 조회 */
	public List<Map<String, Object>> listTexam(Map<String, Object> paramMap) throws Exception;
	
	/** 조회된 총 시험 수 조회 */
	public int countListTexam(Map<String, Object> paramMap) throws Exception;
	
	/** 문항 작성 수 확인 */
	public int takeExamChk(Map<String, Object> paramMap) throws Exception;
	
	/** 시험 정보 가져오기 */
	public Map<String, String> takeExamGetInfo(Map<String, Object> paramMap) throws Exception;
	
	/** 시험 문항 조회 */
	public List<Map<String, Object>> callQuestionList(Map<String, Object> paramMap) throws Exception;
	
	/** 시험 문항 수 조회 */
	public int callQuestionListCnt(Map<String, Object> paramMap) throws Exception;
	
	/** 답안 제출 */
	public int submitExam(Map<String, Object> paramMap) throws Exception;
	
	/** DB에서 정답 가져오기 */
	public String solGroup(Map<String, Object> paramMap) throws Exception;
	
	/** qNo를 순서대로 출력(시험 중도 종료 시) */
	public String selectQno(Map<String, Object> paramMap) throws Exception;
	
	/** DB에 학생 점수 UPDATE */
	public int updateScore(Map<String, Object> paramMap) throws Exception;
}
