package kr.happyjob.study.mng.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.mng.dao.TakeExamDao;
import kr.happyjob.study.mng.model.ExamMgtModel;

@Service
public class TakeExamServiceImpl implements TakeExamService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@Autowired
	TakeExamDao takeExamDao;

	/** 시험 목록 조회 */
	public List<Map<String, Object>> listTexam(Map<String, Object> paramMap) throws Exception {
		
		List<Map<String, Object>> listTexam = takeExamDao.listTexam(paramMap);
		return listTexam;
	}

	/** 조회된 총 시험 수 조회 */
	public int countListTexam(Map<String, Object> paramMap) throws Exception {
		
		int totalCount = takeExamDao.countListTexam(paramMap);
		return totalCount;
	}

	/** 문항 작성 수 확인 */
	public int takeExamChk(Map<String, Object> paramMap) throws Exception {
		
		int inputAnswerCnt = takeExamDao.takeExamChk(paramMap);
		return inputAnswerCnt;
	}
	
	/** 시험 정보 가져오기 */
	public Map<String, String> takeExamGetInfo(Map<String, Object> paramMap) throws Exception {
		
		Map<String, String> examInfoMap = takeExamDao.takeExamGetInfo(paramMap);
		return examInfoMap;
	}
	
	/** 시험 문항 조회 */
	public List<Map<String, Object>> callQuestionList(Map<String, Object> paramMap) throws Exception {
		
		List<Map<String, Object>> qListMap = takeExamDao.callQuestionList(paramMap);
		
		int listSize = qListMap.size();
		
		// "<", ">"를 jsp에 출력하면 HTML 태그로 인식하므로 replace 메소드로 교체해 준 뒤, 다시 넣어 줌.
		for (int i = 0; i < listSize; i++) {
			Map<String, Object> qMap = qListMap.get(i);
			qMap.put("question", String.valueOf(qMap.get("question")).replace(">","&gt;").replace("<","&lt;"));
			qMap.put("one", String.valueOf(qMap.get("one")).replace(">","&gt;").replace("<","&lt;"));
			qMap.put("two", String.valueOf(qMap.get("two")).replace(">","&gt;").replace("<","&lt;"));
			qMap.put("three", String.valueOf(qMap.get("three")).replace(">","&gt;").replace("<","&lt;"));
			qMap.put("four", String.valueOf(qMap.get("four")).replace(">","&gt;").replace("<","&lt;"));
			qListMap.set(i, qMap);
		}
		
		return qListMap;
	}

	/** 시험 문항 수 조회 */
	public int callQuestionListCnt(Map<String, Object> paramMap) throws Exception {
		
		int qlistCnt = takeExamDao.callQuestionListCnt(paramMap);
		return qlistCnt;
	}
	
	/** 답안 제출 */
	public int submitExam(Map<String, Object> paramMap) throws Exception {
		
		int result = takeExamDao.submitExam(paramMap);
		return result;
	}
	
	/** DB에서 정답 가져오기 */
	public String solGroup(Map<String, Object> paramMap) throws Exception {
		
		String solGroup = takeExamDao.solGroup(paramMap);
		return solGroup;
	}
	
	/** qNo를 순서대로 출력(시험 중도 종료 시) */
	public String selectQno(Map<String, Object> paramMap) throws Exception {
		
		String qNoGroup = takeExamDao.selectQno(paramMap);
		return qNoGroup;
	}
	
	/** DB에 학생 점수 UPDATE */
	public int updateScore(Map<String, Object> paramMap) throws Exception {
		
		int markResult = takeExamDao.updateScore(paramMap);
		return markResult;
	}
}
