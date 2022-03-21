package kr.happyjob.study.lec.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.lec.dao.LectureFeedbackDAO;


@Service
public class LectureFeedbackServiceImpl implements LectureFeedbackService {
   
   @Autowired
   LectureFeedbackDAO lectureFeedbackDAO;

	/* 강의피드백 목록 총건 */
	@Override
	public int feedbackListCnt(Map<String, Object> paramMap) {
		return lectureFeedbackDAO.feedbackListCnt(paramMap);
	}

	/* 강의피드백 목록조회 */
	@Override
	public List<Map<String, Object>> feedbackListSelect(Map<String, Object> paramMap) {
		return lectureFeedbackDAO.feedbackListSelect(paramMap);
	}

	@Override
	public Map<String, Object> FBselectDetail(int appraisal_no) {
		return lectureFeedbackDAO.FBselectDetail(appraisal_no);
	}

	@Override
	public int FBdelete(int appraisal_no) {
		return lectureFeedbackDAO.FBdelete(appraisal_no);
	}
	   
}
