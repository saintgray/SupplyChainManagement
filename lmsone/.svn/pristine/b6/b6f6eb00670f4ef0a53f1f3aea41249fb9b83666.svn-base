package kr.happyjob.study.sup.service;

import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.happyjob.study.sup.dao.AwardMgtDao;
import kr.happyjob.study.sup.model.AwardMgtModel;

@Service
public class AwardMgtServiceImpl implements AwardMgtService {

  @Autowired
  AwardMgtDao awardMgtDao;

  /** 수상 목록 조회 */
  public List<AwardMgtModel> listAward(Map<String, Object> paramMap) {
    return awardMgtDao.listAward(paramMap);
  }

  /** 수상 목록 카운트 조회 */
  public int countListAward(Map<String, Object> paramMap) {
    return awardMgtDao.countListAward(paramMap);

  }

  /** 수상 등록 */
  public void insertAward(Map<String, Object> paramMap) {
    awardMgtDao.insertAward(paramMap);
  }

  /** 수상 수정 */
  public void updateAward(Map<String, Object> paramMap) {
    awardMgtDao.updateAward(paramMap);
  }

  /** 상담 조회 */
  public AwardMgtModel selectAward(Map<String, Object> paramMap) {
    return awardMgtDao.selectAward(paramMap);
  }

  //  /** 과정 목록 조회 */
  //  public List<CourseModel> listCourse(Map<String, Object> paramMap) {
  //    return adviceMgtDao.listCourse(paramMap);
  //  }
  //
  //  /** 과정 목록 카운트 조회 */
  //  public int countListCourse(Map<String, Object> paramMap) {
  //    return adviceMgtDao.countListCourse(paramMap);
  //  }
  //
  //  /** 수강 학생 목록 조회 */
  //  public List<AdviceMgtModel> listUser(Map<String, Object> paramMap) {
  //    return adviceMgtDao.listUser(paramMap);
  //  }
  //
  //  /** 수강 학생 목록 카운트 조회 */
  //  public int countListUser(Map<String, Object> paramMap) {
  //    return adviceMgtDao.countListUser(paramMap);
  //  }
  //
  //  /** 상담 목록 조회 */
  //  public List<AdviceMgtModel> listAdvice(Map<String, Object> paramMap) {
  //    return adviceMgtDao.listAdvice(paramMap);
  //  }
  //  
  //  /** 상담 조회 */
  //  public AdviceMgtModel selectConsult(Map<String, Object> paramMap) {
  //	  return adviceMgtDao.selectConsult(paramMap);
  //  }
  //
  //  /** 상담 목록 카운트 조회 */
  //  public int countListAdvice(Map<String, Object> paramMap) {
  //    return adviceMgtDao.countListAdvice(paramMap);
  //  }
  //
  //  /** 상담 등록 */
  //  public void insertConsult(Map<String, Object> paramMap) {
  //	  adviceMgtDao.insertConsult(paramMap);
  //  }
  //  
  //  /** 상담 수정 */
  //  public void updateConsult(Map<String, Object> paramMap) {
  //	  adviceMgtDao.updateConsult(paramMap);
  //  }

  //  
  //  /** 과정 상세 조회 */
  //  public CourseModel selectCourse(Map<String, Object> paramMap) {
  //	return courseDao.selectCourse(paramMap);
  //	}
  //  
  //  /** 수강신청 */
  //  public void insertCourse(Map<String, Object> paramMap) {
  //	  courseDao.insertCourse(paramMap);
  //  }
  //  
  //  /** 수강신청 인원 조회 */
  //  public int countListUser(Map<String, Object> paramMap) {
  //	  return courseDao.countListUser(paramMap);
  //  }

}
