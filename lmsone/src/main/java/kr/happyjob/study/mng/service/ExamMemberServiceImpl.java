package kr.happyjob.study.mng.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.mng.dao.ExamMemberDao;

@Service
public class ExamMemberServiceImpl implements ExamMemberService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@Autowired
	ExamMemberDao examMemberDao;

	/** 시험 목록 조회 */
	public List<Map<String, Object>> listExam2(Map<String, Object> paramMap) throws Exception {
		List<Map<String, Object>> listExam2 = examMemberDao.listExam2(paramMap);

		return listExam2;
	}

	/** 조회된 총 시험 수 조회 */
	public int countListExam2(Map<String, Object> paramMap) throws Exception {
		int totalCount = examMemberDao.countListExam2(paramMap);
		return totalCount;
	}

	/** 미출제 시험 유형 확인 */
	public Map<String, String> typeNullChk(Map<String, Object> paramMap) throws Exception {
		Map<String, String> typeNullMap = examMemberDao.typeNullChk(paramMap);
		return typeNullMap;
	}
	
	/** 선택한 시험의 응시자 목록 조회 */
	public List<Map<String, Object>> listExamMember(Map<String, Object> paramMap) throws Exception {
		List<Map<String, Object>> listExamMember = examMemberDao.listExamMember(paramMap);
		
		int memListCnt = listExamMember.size();
		
		for (int i = 0; i < memListCnt; i++) {
			Map<String, Object> memMap = listExamMember.get(i);
			if ((memMap.get("state") + "").equals("PASS")) {
				memMap.put("state", "<span class='font_blue'><strong>통과</strong></span>");
			} else if ((memMap.get("state") + "").equals("FAIL")) {
				memMap.put("state", "<span class='font_red'><strong>과락</strong></span>");
			} 
		}

		return listExamMember;
	}

	/** 선택한 시험의 응시자 수 조회 */
	public int countListExamMember(Map<String, Object> paramMap) throws Exception {
		int examMemCnt = examMemberDao.countListExamMember(paramMap);
		return examMemCnt;
	}
}
