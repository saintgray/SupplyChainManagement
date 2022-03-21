package kr.happyjob.study.sup.service;

import java.util.List;
import java.util.Map;
import kr.happyjob.study.sup.model.AdviceMgtModel;
import kr.happyjob.study.sup.model.CourseModel;

public interface AdviceMgtService {

  /** 과정 목록 조회 */
  public List<CourseModel> listCourse(Map<String, Object> paramMap);

  /** 과정 목록 카운트 조회 */
  public int countListCourse(Map<String, Object> paramMap);

  /** 수강 학생 목록 조회 */
  public List<AdviceMgtModel> listUser(Map<String, Object> paramMap);

  /** 수강 학생 목록 카운트 조회 */
  public int countListUser(Map<String, Object> paramMap);

  /** 상담 목록 조회 */
  public List<AdviceMgtModel> listAdvice(Map<String, Object> paramMap);
  
  /** 상담 조회 */
  public AdviceMgtModel selectConsult(Map<String, Object> paramMap);

  /** 상담 목록 카운트 조회 */
  public int countListAdvice(Map<String, Object> paramMap);

  /** 상담 등록 */
  public void insertConsult(Map<String, Object> paramMap);
  
  /** 상담 수정 */
  public void updateConsult(Map<String, Object> paramMap);

  //  /** 과정 상세 조회 */
  //  public CourseModel selectCourse(Map<String, Object> paramMap);
  //  
  //  /** 수강신청 */
  //  public void insertCourse(Map<String, Object> paramMap);
  //  
  //  /** 수강신청 인원 조회 */
  //  public int countListUser(Map<String, Object> paramMap);

}
