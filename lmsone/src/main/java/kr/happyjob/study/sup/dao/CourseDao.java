package kr.happyjob.study.sup.dao;

import java.util.List;
import java.util.Map;
import kr.happyjob.study.sup.model.CourseModel;
import kr.happyjob.study.system.model.ComnGrpCodModel;

public interface CourseDao {

  /** 과정 목록 조회 */
  public List<CourseModel> listCourse(Map<String, Object> paramMap);

  /** 과정 목록 카운트 조회 */
  public int countListCourse(Map<String, Object> paramMap);
  
  /** 과정 상세 조회 */
  public CourseModel selectCourse(Map<String, Object> paramMap);
  
  /** 수강신청 */
  public void insertCourse(Map<String, Object> paramMap);
  
  /** 수강신청 인원 조회 */
  public int countListUser(Map<String, Object> paramMap);

}
