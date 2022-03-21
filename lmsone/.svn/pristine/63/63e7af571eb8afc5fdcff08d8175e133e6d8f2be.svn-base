package kr.happyjob.study.mng.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.mng.model.ExamMgtModel;
import kr.happyjob.study.mng.dao.ExamDao;

@Service
public class ExamServiceImpl implements ExamService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	ExamDao examDao;
	
	/** 강의 목록 조회 */
	public List<ExamMgtModel> listClass(Map<String, Object> paramMap) throws Exception {	
		List<ExamMgtModel> listClass = examDao.listClass(paramMap);
		
		return listClass;
	}
	
	/** 조회된 총 강의 수 조회 */
	public int countListClass(Map<String, Object> paramMap) throws Exception {
		int totalCount = examDao.countListClass(paramMap);
		return totalCount;
	}
	
	/** 선택한 강의에 등록된 시험 조회 */
	public List<ExamMgtModel> listExam(Map<String, Object> paramMap) throws Exception {
		List<ExamMgtModel> listExam = examDao.listExam(paramMap);	
		
		int listSize = listExam.size();
		
		// "<", ">"를 jsp에 출력하면 HTML 태그로 인식하므로 replace 메소드로 교체해 준 뒤, 다시 넣어 줌.
		for (int i = 0; i < listSize; i++) {
			ExamMgtModel emm = listExam.get(i);
			emm.setqContent(emm.getqContent().replace(">","&gt;").replace("<","&lt;"));
			emm.setqOne(emm.getqOne().replace(">","&gt;").replace("<","&lt;"));
			emm.setqTwo(emm.getqTwo().replace(">","&gt;").replace("<","&lt;"));
			emm.setqThree(emm.getqThree().replace(">","&gt;").replace("<","&lt;"));
			emm.setqFour(emm.getqFour().replace(">","&gt;").replace("<","&lt;"));
			listExam.set(i, emm);
		}
		
		return listExam;
	} 
	
	/** 선택한 강의에 등록된 시험 총 개수 및 가장 높은 문항 번호 조회 */
	public Map<String, Object> countMapExam(Map<String, Object> paramMap) throws Exception {
		Map<String, Object> cntMap = examDao.countMapExam(paramMap);
		return cntMap;
	} 
	
	/** 문항 상세 조회 */
	public Map<String, Object> selectQuestion(Map<String, Object> paramMap) throws Exception {
		
		Map<String, Object> questionDtlMap = examDao.selectQuestion(paramMap);
		return questionDtlMap;
	}
	
	/** 응시자 수 조회 */
	public Map<String, Object> chkMemberCnt(Map<String, Object> paramMap) throws Exception {
		
		Map<String, Object> memberCntMap = examDao.chkMemberCnt(paramMap);
		return memberCntMap;
	}
	
	/** 문항 저장 INSERT */
	public int insertQuestion(Map<String, Object> paramMap) throws Exception {
		
		int ret = examDao.insertQuestion(paramMap);
		
		logger.info("::::examDao.insertQuestion::::");
		logger.info("   - ret : " + ret);
		
		return ret;
	}
	
	/** 문항 저장 UPDATE */
	public int updateQuestion(Map<String, Object> paramMap) throws Exception {
		
		int ret = examDao.updateQuestion(paramMap);
		
		logger.info("::::examDao.updateQuestion::::");
		logger.info("   - ret : " + ret);
		
		return ret;
	}
	
	/** 문항 관리 폼 문제 번호 중복 검사 */
	public int qNoCheck(Map<String, Object> paramMap) throws Exception {
		
		int result = examDao.qNoCheck(paramMap);

		return result;
	}
	
	/** 문항 삭제 DELETE */
	public int deleteQuestion(Map<String, Object> paramMap) throws Exception {
		
		int ret = examDao.deleteQuestion(paramMap);
		
		logger.info("::::examDao.deleteQuestion::::");
		logger.info("   - ret : " + ret);
		
		return ret;
	}
}
